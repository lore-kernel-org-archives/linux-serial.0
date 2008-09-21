From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: [PATCH] max3100 driver
Date: Sun, 21 Sep 2008 09:09:21 -0700
Message-ID: <87bpyhfpla.fsf@blp.benpfaff.org>
References: <1221895208650-git-send-email-chripell@gmail.com> <20080920012454.e40f03cc.akpm@linux-foundation.org> <20080920065652.11d76780@infradead.org>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753240AbYIUQGX@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> I do have a question though: what does a signed bitfield of 1 mean?
> I mean.. the variables are "int", so signed.... where will the compil=
er
> store the sign bit???

Whether a bit-field declared as type "int" is signed or unsigned
is compiler implementation-defined.  As C99 6.7.2 says (there is
similar text in C89):

     ...for bit-fields, it is implementation-defined whether the
     specifier int designates the same type as signed int or the
     same type as unsigned int.

Thus, it is never a good idea to declare a bit-field as plain
"int".  Declare it as "signed int" or "unsigned int" instead.
--=20
"Mon peu de succ=E8s pr=E8s des femmes est toujours venu de les trop ai=
mer."
--Jean-Jacques Rousseau
