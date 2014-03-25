From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] serial: sirf: update copyright years to 2014
Date: Tue, 25 Mar 2014 10:51:49 +0800
Message-ID: <CAGsJ_4zVzgJF7T9sJco58Jcb4zzNrQ+BGCEwLa7_xF0qdFrcuQ@mail.gmail.com>
References: <CAGsJ_4zuju7x06nvZOMKvU8xfULy5bgNTyENSfmPVNg6TcwRdQ@mail.gmail.com>
 <20140212143744.GA10095@kroah.com> <CAGsJ_4xTfsYJMj7MkzKigQcdiyozK-fqq=JYosHMr9=jx7XQyQ@mail.gmail.com>
 <20140212161230.GA22431@kroah.com> <CAGsJ_4yXjRFxcazwx+Zfxm4_2njhMeRVRKXEM2w4wKsGPas6yA@mail.gmail.com>
 <20140212163810.GA22377@kroah.com> <CAGsJ_4x-9MiX_CMgQAhmUDQFXvCo0Nd2Y5AkVu+ePvurbefiFQ@mail.gmail.com>
 <20140214171424.GA26194@kroah.com> <CAGsJ_4wu80_50Vb4tzBT6Uug+JaSgajdTA6N5fK-FtxvCRxxeQ@mail.gmail.com>
 <CAGsJ_4yJACM9ZzzQvdNK3fVXW6-c6zaScYFx0Rcy_=rZkNHMjw@mail.gmail.com> <20140318023328.GA21938@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:41327 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbaCYCwL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Mar 2014 22:52:11 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so6286252pab.41
        for <linux-serial@vger.kernel.org>; Mon, 24 Mar 2014 19:52:10 -0700 (PDT)
In-Reply-To: <20140318023328.GA21938@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <Baohua.Song@csr.com>

2014-03-18 10:33 GMT+08:00 Greg KH <gregkh@linuxfoundation.org>:
> On Tue, Mar 18, 2014 at 10:25:50AM +0800, Barry Song wrote:
>> 2014-02-19 13:16 GMT+08:00 Barry Song <21cnbao@gmail.com>:
>> > 2014-02-15 1:14 GMT+08:00 Greg KH <gregkh@linuxfoundation.org>:
>> >> On Thu, Feb 13, 2014 at 10:27:17AM +0800, Barry Song wrote:
>> >>> 2014-02-13 0:38 GMT+08:00 Greg KH <gregkh@linuxfoundation.org>:
>> >>> > On Thu, Feb 13, 2014 at 12:26:35AM +0800, Barry Song wrote:
>> >>> >> > Well, your 2012 change doesn't seem to be "significant" to =
warrent a
>> >>> >> > normal copyright update, but the update is usually "less st=
rict" than an
>> >>> >> > original mark, so that might be ok, now that I review these=
 closer.
>> >>> >> >
>> >>> >> > But I'd still prefer to get the opinion of your lawyer abou=
t this.
>> >>> >>
>> >>> >> Greg, thanks. i will ask csr lawyer to give some feedback if =
i can :-)
>> >>> >>
>> >>> >> i am not an expert of  copyright and i am really ignorant on =
it. in my
>> >>> >> shallow understand, it seems it is difficult to evaluate what=
 is
>> >>> >> "significant" and what is not important as it highly depends =
on the
>> >>> >> personal opinion? is this something like "there are a thousan=
d Hamlets
>> >>> >> in a thousand people's eyes"?
>> >>> >
>> >>> > It does "depend", but the "general" rule that most everyone fo=
llows, and
>> >>> > what I have been advised to stick to, is "1/3 of the file is
>> >>> > modified/added to" by a company/developer.  If that happens, t=
hen a
>> >>> > copyright mark is allowed.  That has worked well over the many=
 years of
>> >>> > me having to deal with this, but the issue of "extending" the =
mark
>> >>> > hasn't really been discussed, so I don't know if that same rul=
e applies
>> >>> > here or not.
>> >>> >
>> >>> > Feedback from your lawyer would be great to have on this, than=
ks.
>> >>> >
>> >>>
>> >>> Greg, i am inviting our lawyer Cherrie into this, as she is mayb=
e
>> >>> busy, so we might wait some time.
>> >>
>> >> In my research, it's become apparent that the copyright notice sh=
ould
>> >> just be removed entirely from the files, as they don't mean anyth=
ing
>> >> from a legal standpoint, so updating them shouldn't really be don=
e
>> >> either, as they don't mean anything.  Although one could argue, i=
f they
>> >> don't mean anything, updating it shouldn't matter, but I don't th=
ink
>> >> that the transitive is true here...
>> >>
>> >> It will be interesting to find out what your lawyer says about th=
is.
>> >
>> > Greg, all your comments have been forwarded to our layer and couns=
el.
>> > pls wait for some time :-)
>>
>> Greg,
>>
>> here i got some comments from the lawyer.
>> "
>> the reason that people want the copyright notice to include 2014 is =
to
>> ensure that the copyrighted works have the longest possible life
>> available under copyright protection.
>
> But just putting a number in a file does not have anything to do with
> the copyright of the file itself, right?  It can be a "hint", but a l=
ot
> of projects are doing away with these types of file "markings" entire=
ly,
> as it has been proven to not mean anything.
>
>> if the changes that have been made to CSR=E2=80=99s source code for =
the driver
>> program (which was originally authored in 2011 - entirely using CSR
>> original source code) are insignificant =E2=80=94 for example, just =
adding or
>> editing a few lines of code among hundreds or thousands (or more)
>> lines of code, those changes are unlikely to be seen as a "derivativ=
e
>> work" that would be the subject of independent copyright protection
>> (for the changed portion) as of the year in which those changes were
>> made.  If significant changes were made to the source code, such tha=
t
>> new functionality were added, or a similar upgrade (for efficiency,
>> etc.), or something along those lines =E2=80=94 even if the changes =
only
>> amounted to 5 or 10% of the code total =E2=80=94 that could be deeme=
d a
>> derivative work that would be able to have its own copyright notice =
in
>> the year in which the changes were created/authored.  There is no ha=
rd
>> and fast rule on the percentage.
>>
>> for the general guideline that if one-third or more of the program=E2=
=80=99s
>> source code has been updated/changed/added, then an updated year can
>> be set forth in the copyright notice.  That guideline, while useful =
as
>> a minor rule of thumb, is not required by law or anything else to my
>> knowledge =E2=80=94 the crux of the issue is really whether the chan=
ges amount
>> to a derivative work."
>
> That's an interesting statement, but not what my lawyer has advised m=
e
> to abide by.
>
>> and after talking with the lawyer, if a new year is added in copyrig=
ht
>> notice, it is for protecting the changes in 2013. so "extend the
>> copyright year" should be wrong. it is not extending the exiting
>> copyright, it is a new year to protect the new codes changed in the
>> year.
>
> But nothing was changed in your patch in the "code" section, right?

Greg, i think the changes in 2013 are important and we should have
copyright protection for it.
commit 5df831117b85a0 "serial: sirf: make the driver also support
USP-based UART" we added support for a new port, USP port, it is a
real code section.

and commit 8316d04c42b94e "serial: sirf: add DMA support using
dmaengine APIs" added DMA support, which is also code section changes.

>
> Anyway, care to resend this patch, based on the above information, an=
d
> we can try this again?
>
> thanks,
>
> greg k-h

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
