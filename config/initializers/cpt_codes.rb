CPT_CODES = HashWithIndifferentAccess.new(YAML.load(File.read(File.expand_path('../../../lib/assets/cpt_codes.yml', __FILE__))))