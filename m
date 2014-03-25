From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: sirf: update copyright years to 2014
Date: Tue, 25 Mar 2014 05:51:01 -0700
Message-ID: <20140325125101.GB5776@kroah.com>
References: <CAGsJ_4xTfsYJMj7MkzKigQcdiyozK-fqq=JYosHMr9=jx7XQyQ@mail.gmail.com>
 <20140212161230.GA22431@kroah.com>
 <CAGsJ_4yXjRFxcazwx+Zfxm4_2njhMeRVRKXEM2w4wKsGPas6yA@mail.gmail.com>
 <20140212163810.GA22377@kroah.com>
 <CAGsJ_4x-9MiX_CMgQAhmUDQFXvCo0Nd2Y5AkVu+ePvurbefiFQ@mail.gmail.com>
 <20140214171424.GA26194@kroah.com>
 <CAGsJ_4wu80_50Vb4tzBT6Uug+JaSgajdTA6N5fK-FtxvCRxxeQ@mail.gmail.com>
 <CAGsJ_4yJACM9ZzzQvdNK3fVXW6-c6zaScYFx0Rcy_=rZkNHMjw@mail.gmail.com>
 <20140318023328.GA21938@kroah.com>
 <CAGsJ_4zVzgJF7T9sJco58Jcb4zzNrQ+BGCEwLa7_xF0qdFrcuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44588 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbaCYMtY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Mar 2014 08:49:24 -0400
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zVzgJF7T9sJco58Jcb4zzNrQ+BGCEwLa7_xF0qdFrcuQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <Baohua.Song@csr.com>

On Tue, Mar 25, 2014 at 10:51:49AM +0800, Barry Song wrote:
> 2014-03-18 10:33 GMT+08:00 Greg KH <gregkh@linuxfoundation.org>:
> > On Tue, Mar 18, 2014 at 10:25:50AM +0800, Barry Song wrote:
> >> 2014-02-19 13:16 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> >> > 2014-02-15 1:14 GMT+08:00 Greg KH <gregkh@linuxfoundation.org>:
> >> >> On Thu, Feb 13, 2014 at 10:27:17AM +0800, Barry Song wrote:
> >> >>> 2014-02-13 0:38 GMT+08:00 Greg KH <gregkh@linuxfoundation.org>=
:
> >> >>> > On Thu, Feb 13, 2014 at 12:26:35AM +0800, Barry Song wrote:
> >> >>> >> > Well, your 2012 change doesn't seem to be "significant" t=
o warrent a
> >> >>> >> > normal copyright update, but the update is usually "less =
strict" than an
> >> >>> >> > original mark, so that might be ok, now that I review the=
se closer.
> >> >>> >> >
> >> >>> >> > But I'd still prefer to get the opinion of your lawyer ab=
out this.
> >> >>> >>
> >> >>> >> Greg, thanks. i will ask csr lawyer to give some feedback i=
f i can :-)
> >> >>> >>
> >> >>> >> i am not an expert of  copyright and i am really ignorant o=
n it. in my
> >> >>> >> shallow understand, it seems it is difficult to evaluate wh=
at is
> >> >>> >> "significant" and what is not important as it highly depend=
s on the
> >> >>> >> personal opinion? is this something like "there are a thous=
and Hamlets
> >> >>> >> in a thousand people's eyes"?
> >> >>> >
> >> >>> > It does "depend", but the "general" rule that most everyone =
follows, and
> >> >>> > what I have been advised to stick to, is "1/3 of the file is
> >> >>> > modified/added to" by a company/developer.  If that happens,=
 then a
> >> >>> > copyright mark is allowed.  That has worked well over the ma=
ny years of
> >> >>> > me having to deal with this, but the issue of "extending" th=
e mark
> >> >>> > hasn't really been discussed, so I don't know if that same r=
ule applies
> >> >>> > here or not.
> >> >>> >
> >> >>> > Feedback from your lawyer would be great to have on this, th=
anks.
> >> >>> >
> >> >>>
> >> >>> Greg, i am inviting our lawyer Cherrie into this, as she is ma=
ybe
> >> >>> busy, so we might wait some time.
> >> >>
> >> >> In my research, it's become apparent that the copyright notice =
should
> >> >> just be removed entirely from the files, as they don't mean any=
thing
> >> >> from a legal standpoint, so updating them shouldn't really be d=
one
> >> >> either, as they don't mean anything.  Although one could argue,=
 if they
> >> >> don't mean anything, updating it shouldn't matter, but I don't =
think
> >> >> that the transitive is true here...
> >> >>
> >> >> It will be interesting to find out what your lawyer says about =
this.
> >> >
> >> > Greg, all your comments have been forwarded to our layer and cou=
nsel.
> >> > pls wait for some time :-)
> >>
> >> Greg,
> >>
> >> here i got some comments from the lawyer.
> >> "
> >> the reason that people want the copyright notice to include 2014 i=
s to
> >> ensure that the copyrighted works have the longest possible life
> >> available under copyright protection.
> >
> > But just putting a number in a file does not have anything to do wi=
th
> > the copyright of the file itself, right?  It can be a "hint", but a=
 lot
> > of projects are doing away with these types of file "markings" enti=
rely,
> > as it has been proven to not mean anything.
> >
> >> if the changes that have been made to CSR=E2=80=99s source code fo=
r the driver
> >> program (which was originally authored in 2011 - entirely using CS=
R
> >> original source code) are insignificant =E2=80=94 for example, jus=
t adding or
> >> editing a few lines of code among hundreds or thousands (or more)
> >> lines of code, those changes are unlikely to be seen as a "derivat=
ive
> >> work" that would be the subject of independent copyright protectio=
n
> >> (for the changed portion) as of the year in which those changes we=
re
> >> made.  If significant changes were made to the source code, such t=
hat
> >> new functionality were added, or a similar upgrade (for efficiency=
,
> >> etc.), or something along those lines =E2=80=94 even if the change=
s only
> >> amounted to 5 or 10% of the code total =E2=80=94 that could be dee=
med a
> >> derivative work that would be able to have its own copyright notic=
e in
> >> the year in which the changes were created/authored.  There is no =
hard
> >> and fast rule on the percentage.
> >>
> >> for the general guideline that if one-third or more of the program=
=E2=80=99s
> >> source code has been updated/changed/added, then an updated year c=
an
> >> be set forth in the copyright notice.  That guideline, while usefu=
l as
> >> a minor rule of thumb, is not required by law or anything else to =
my
> >> knowledge =E2=80=94 the crux of the issue is really whether the ch=
anges amount
> >> to a derivative work."
> >
> > That's an interesting statement, but not what my lawyer has advised=
 me
> > to abide by.
> >
> >> and after talking with the lawyer, if a new year is added in copyr=
ight
> >> notice, it is for protecting the changes in 2013. so "extend the
> >> copyright year" should be wrong. it is not extending the exiting
> >> copyright, it is a new year to protect the new codes changed in th=
e
> >> year.
> >
> > But nothing was changed in your patch in the "code" section, right?
>=20
> Greg, i think the changes in 2013 are important and we should have
> copyright protection for it.

But you already have that, there's no need to just add a line to a file
to somehow get that in the legal sense.  You already have the copyright
in that year, on that file, without the "mark" as the "mark" doesn't
mean anything anymore (and hasn't for about 20+ years from what I have
been told.)

And your lawyer should know that, if not, I suggest getting a new lawye=
r :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
