begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  require 'spec'
end

require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'rake/gempackagetask'

# allow require of spec/spec_helper
$LOAD_PATH.unshift File.dirname(__FILE__) + '/../'
$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'

require 'editx'

desc "Default Task"
task :default => [ :spec ]

desc 'Generate documentation'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'EDItX'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.markdown')
  rdoc.rdoc_files.include('CHANGELOG')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.rdoc_files.include('spec/**/*.*')
end

desc "Run the specs under spec"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Generate RCov reports"
Spec::Rake::SpecTask.new(:rcov) do |t|
  t.libs << 'lib'
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['-c']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end

spec = Gem::Specification.new do |s|
  s.name              = "editx"
  s.version           = EDItX::Version::String
  s.summary           = "A convient mapping between ruby objects and the various EDItX XML specifications"
  s.description       = "A convient mapping between ruby objects and the various EDItX XML specifications"
  s.author            = "James Healy"
  s.email             = "jimmy@deefa.com"
  s.has_rdoc          = true
  s.rubyforge_project = "rbook"
  s.homepage          = "http://github.com/yob/editx/tree/master"
  s.rdoc_options     << "--title" << "EDItX - Working with the EDItX XML specs" <<
                        "--line-numbers"
  s.test_files        = FileList["spec/**/*.rb"]
  s.files             = FileList[
    "lib/**/*.rb",
    "README.markdown",
    "CHANGELOG",
    "schemas/*.xsd",
    "tasks/**/*.rb",
    "tasks/**/*.rake"
  ]
  s.add_dependency('roxml', '>=3.1.1')
  s.add_dependency('andand')
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end
