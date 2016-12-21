﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace XSharpModel
{
    [DebuggerDisplay("{FullPath:nq}")]
    public class XFile
    {
        private List<String> _usings;
        private string filePath;
        private List<XType> _typeList;
        private XType _globalType;

        public XFile( string fullPath )
        {
            _typeList = new List<XType>();
            _usings = new List<string>();
            this.filePath = fullPath;
            _globalType = XType.CreateGlobalType();
            _typeList.Add(_globalType);
        }

        public XProject Project { get; internal set; }

        public String Name
        {
            get
            {
                return System.IO.Path.GetFileNameWithoutExtension(this.filePath);
            }
        }

        public XType GlobalType => _globalType;

        public string FullPath
        {
            get
            {
                return filePath;
            }

            set
            {
                filePath = value;
            }
        }

        public List<string> Usings
        {
            get
            {
                return _usings;
            }

        }

        public List<XType> TypeList
        {
            get
            {
                return _typeList;
            }

            set
            {
                _typeList = value;
            }
        }

    }
}