import sqlite3
from flask import Flask, g
from flask_restful import reqparse, Api, Resource
from flask_restful_extend import support_jsonp

# Boilerplate
DATABASE = 'phage.db'

'''
SCHEMA:
(ppa,name,stocks,sample_type,parent_ppa,plaque_archive_id,external_source_id,host_isolation,host_lysate,host_all,experiment_type,source_type,source_date,source_comments,source_poc,morphotype_em,morphotype_genome,cluster_id_kt,cluster_id_ktandb,micrograph_directory,plaque_image,density_iodixanol,density_cscl,illumina,genome_length,seq_gbk,seq_gen,seq_fna,seq_faa,annotation_file,ncbi_accesseion,pac_bio);
'''

app = Flask(__name__)
api = Api(app)
support_jsonp(api)


@app.before_request
def before_request():
    g._db = sqlite3.connect(DATABASE)
    g._db.row_factory = sqlite3.Row


@app.teardown_request
def teardown_request(exception):
    if hasattr(g, '_db'):
        g._db.close()


def get_db():
    db = getattr(g, '_db', None)
    if db is None:
        db = g._db = sqlite3.connect(DATABASE)
        db.row_factory = sqlite3.Row
    return db


def query_db(query, args=(), one=False):
    cur = get_db().execute(query, args)
    res = cur.fetchall()
    return {key: res[0][key] for key in res[0].keys()} if one else [{key: row[key] for key in row.keys()} for row in res]


# Resouces


class Phage(Resource):
    def get(self, ppa_id):
        query = "SELECT * FROM phage WHERE ppa='%s'" % ppa_id
        return query_db(query, one=True)


class Phage_List(Resource):
    def get(self):
        query = "SELECT ppa,name FROM phage"
        return query_db(query)


class Phage_By_Host(Resource):
    def get(self, host):
        query = "SELECT ppa,name FROM phage WHERE host_isolation='%s'" % host
        return query_db(query)

api.add_resource(Phage_List, '/api/phage/')
api.add_resource(Phage, '/api/phage/<string:ppa_id>/')
api.add_resource(Phage_By_Host, '/api/phage/host_isolation/<string:host>/')

parser = reqparse.RequestParser()

if __name__ == '__main__':
    app.run(debug=True)
