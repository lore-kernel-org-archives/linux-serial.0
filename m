From: Alexander Bartolich <alexander.bartolich@gmx.at>
Subject: Re: Maintainer needed for Serial-Programming-HOWTO
Date: Fri, 28 Mar 2003 14:51:03 +0100 (MET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3903.1048859463@www31.gmx.net>
References: <20030327225519.GC1233@lafn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: David Lawyer <dave@lafn.org>
Cc: linux-serial@vger.kernel.org, discuss@en.tldp.org

David Lawyer:
> [...] So it needs a new maintainer who will rework it and combine the
> two versions (the 1997 and Vern's 1999 which are very much different)
> or just redo the whole thing from scratch.  Any volunteers?

I had a look on the version shown on en.tldp.org.
Looks nice and cosy.

However, I never saw the new 1999-stuff from Vern.
And and on the few occasions I toyed with serial programming I read
http://www.easysw.com/~mike/serial, not the HOWTO.

> [...] He actually wrote it in Linuxdoc Format but didn't like
> the rendering the "code" environment, etc.  Statements on the
> discussion list about the need to use DocBook and cvs turned him off.=
=20

Not sure whether you are searching a programmer or SGML maintainer.
I am a regular user of minicom, but never seriously fed anything than
a socket to select(2).

I feel confident to solve DocBook issues, though.
There are two things I don't like about Serial-Programming-HOWTO.sgml
on http://cvsview.tldp.org/

1. It is a single file.
   I prefer separate sect1 referenced as system entities.
   But then the whole thing is just 837 lines, real cosy ...

2. The code examples are written inline with <screen>
   This is madness. It it absolutely required to make that
 =20
      <programlisting><inlinemediaobject><imageobject><imagedata
        format=3D"linespecific"
        fileref=3D"example.c"
      /></imageobject></inlinemediaobject></programlisting

   and perhaps wrap a Makefile around that to actually compile and
   test example.c.

Well, I'd do it if I get a separate directory in CVS.
And if you give me a few weeks time.
And if nobody with more programming experience claims it.

--=20
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
Bitte l=E4cheln! Fotogalerie online mit GMX ohne eigene Homepage!

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
