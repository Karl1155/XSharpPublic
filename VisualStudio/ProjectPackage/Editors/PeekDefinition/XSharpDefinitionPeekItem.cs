﻿using System.Collections.Generic;
using Microsoft.VisualStudio.Language.Intellisense;
using Microsoft.VisualStudio.Text;

namespace XSharp.Project
{
    class XSharpDefinitionPeekItem : IPeekableItem
    {
        internal readonly IPeekResultFactory _peekResultFactory;
        internal XSharpModel.XElement _gotoElement;

        public XSharpDefinitionPeekItem(XSharpModel.XElement gotoElement, IPeekResultFactory peekResultFactory)
        {
            _gotoElement = gotoElement;
            _peekResultFactory = peekResultFactory;
        }

        public string DisplayName
        {
            // This is unused, and was supposed to have been removed from IPeekableItem.
            get { return null; }
        }

        public IEnumerable<IPeekRelationship> Relationships
        {
            get { yield return PredefinedPeekRelationships.Definitions; }
        }

        public IPeekResultSource GetOrCreateResultSource(string relationshipName)
        {
            return new XSharpResultSource(this);
        }
    }
}