From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: sirf: update copyright years to 2014
Date: Tue, 18 Mar 2014 02:33:28 +0000
Message-ID: <20140318023328.GA21938@kroah.com>
References: <CAGsJ_4zuju7x06nvZOMKvU8xfULy5bgNTyENSfmPVNg6TcwRdQ@mail.gmail.com>
 <20140212143744.GA10095@kroah.com>
 <CAGsJ_4xTfsYJMj7MkzKigQcdiyozK-fqq=JYosHMr9=jx7XQyQ@mail.gmail.com>
 <20140212161230.GA22431@kroah.com>
 <CAGsJ_4yXjRFxcazwx+Zfxm4_2njhMeRVRKXEM2w4wKsGPas6yA@mail.gmail.com>
 <20140212163810.GA22377@kroah.com>
 <CAGsJ_4x-9MiX_CMgQAhmUDQFXvCo0Nd2Y5AkVu+ePvurbefiFQ@mail.gmail.com>
 <20140214171424.GA26194@kroah.com>
 <CAGsJ_4wu80_50Vb4tzBT6Uug+JaSgajdTA6N5fK-FtxvCRxxeQ@mail.gmail.com>
 <CAGsJ_4yJACM9ZzzQvdNK3fVXW6-c6zaScYFx0Rcy_=rZkNHMjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50398 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbaCRCcP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Mar 2014 22:32:15 -0400
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yJACM9ZzzQvdNK3fVXW6-c6zaScYFx0Rcy_=rZkNHMjw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <Baohua.Song@csr.com>

On Tue, Mar 18, 2014 at 10:25:50AM +0800, Barry Song wrote:
> 2014-02-19 13:16 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> > 2014-02-15 1:14 GMT+08:00 Greg KH <gregkh@linuxfoundation.org>:
> >> On Thu, Feb 13, 2014 at 10:27:17AM +0800, Barry Song wrote:
> >>> 2014-02-13 0:38 GMT+08:00 Greg KH <gregkh@linuxfoundation.org>:
> >>> > On Thu, Feb 13, 2014 at 12:26:35AM +0800, Barry Song wrote:
> >>> >> > Well, your 2012 change doesn't seem to be "significant" to w=
arrent a
> >>> >> > normal copyright update, but the update is usually "less str=
ict" than an
> >>> >> > original mark, so that might be ok, now that I review these =
closer.
> >>> >> >
> >>> >> > But I'd still prefer to get the opinion of your lawyer about=
 this.
> >>> >>
> >>> >> Greg, thanks. i will ask csr lawyer to give some feedback if i=
 can :-)
> >>> >>
> >>> >> i am not an expert of  copyright and i am really ignorant on i=
t. in my
> >>> >> shallow understand, it seems it is difficult to evaluate what =
is
> >>> >> "significant" and what is not important as it highly depends o=
n the
> >>> >> personal opinion? is this something like "there are a thousand=
 Hamlets
> >>> >> in a thousand people's eyes"?
> >>> >
> >>> > It does "depend", but the "general" rule that most everyone fol=
lows, and
> >>> > what I have been advised to stick to, is "1/3 of the file is
> >>> > modified/added to" by a company/developer.  If that happens, th=
en a
> >>> > copyright mark is allowed.  That has worked well over the many =
years of
> >>> > me having to deal with this, but the issue of "extending" the m=
ark
> >>> > hasn't really been discussed, so I don't know if that same rule=
 applies
> >>> > here or not.
> >>> >
> >>> > Feedback from your lawyer would be great to have on this, thank=
s.
> >>> >
> >>>
> >>> Greg, i am inviting our lawyer Cherrie into this, as she is maybe
> >>> busy, so we might wait some time.
> >>
> >> In my research, it's become apparent that the copyright notice sho=
uld
> >> just be removed entirely from the files, as they don't mean anythi=
ng
> >> from a legal standpoint, so updating them shouldn't really be done
> >> either, as they don't mean anything.  Although one could argue, if=
 they
> >> don't mean anything, updating it shouldn't matter, but I don't thi=
nk
> >> that the transitive is true here...
> >>
> >> It will be interesting to find out what your lawyer says about thi=
s.
> >
> > Greg, all your comments have been forwarded to our layer and counse=
l.
> > pls wait for some time :-)
>=20
> Greg,
>=20
> here i got some comments from the lawyer.
> "
> the reason that people want the copyright notice to include 2014 is t=
o
> ensure that the copyrighted works have the longest possible life
> available under copyright protection.

But just putting a number in a file does not have anything to do with
the copyright of the file itself, right?  It can be a "hint", but a lot
of projects are doing away with these types of file "markings" entirely=
,
as it has been proven to not mean anything.

> if the changes that have been made to CSR=E2=80=99s source code for t=
he driver
> program (which was originally authored in 2011 - entirely using CSR
> original source code) are insignificant =E2=80=94 for example, just a=
dding or
> editing a few lines of code among hundreds or thousands (or more)
> lines of code, those changes are unlikely to be seen as a "derivative
> work" that would be the subject of independent copyright protection
> (for the changed portion) as of the year in which those changes were
> made.  If significant changes were made to the source code, such that
> new functionality were added, or a similar upgrade (for efficiency,
> etc.), or something along those lines =E2=80=94 even if the changes o=
nly
> amounted to 5 or 10% of the code total =E2=80=94 that could be deemed=
 a
> derivative work that would be able to have its own copyright notice i=
n
> the year in which the changes were created/authored.  There is no har=
d
> and fast rule on the percentage.
>=20
> for the general guideline that if one-third or more of the program=E2=
=80=99s
> source code has been updated/changed/added, then an updated year can
> be set forth in the copyright notice.  That guideline, while useful a=
s
> a minor rule of thumb, is not required by law or anything else to my
> knowledge =E2=80=94 the crux of the issue is really whether the chang=
es amount
> to a derivative work."

That's an interesting statement, but not what my lawyer has advised me
to abide by.

> and after talking with the lawyer, if a new year is added in copyrigh=
t
> notice, it is for protecting the changes in 2013. so "extend the
> copyright year" should be wrong. it is not extending the exiting
> copyright, it is a new year to protect the new codes changed in the
> year.

But nothing was changed in your patch in the "code" section, right?

Anyway, care to resend this patch, based on the above information, and
we can try this again?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
