import './find_parent_matching.js'

import hljs from 'highlight.js/lib/core'
import swift from 'highlight.js/lib/languages/swift'
import yaml from 'highlight.js/lib/languages/yaml'
import bash from 'highlight.js/lib/languages/bash'

import { ExternalLinkRetargeter } from './external_link_retargeter.js'

hljs.registerLanguage('swift', swift)
hljs.registerLanguage('yaml', swift)
hljs.registerLanguage('bash', bash)
hljs.highlightAll()

new ExternalLinkRetargeter()

import 'normalize.css'
import '../stylesheets/main.scss'
