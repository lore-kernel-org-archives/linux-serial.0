From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] 8250_pci: Replace commits 448ac154 and e86ff4a
Date: Mon, 9 Apr 2012 10:59:04 -0700
Message-ID: <CABE8wwvZYi1e+RUJ2zd7fkkPd5Wi3dsVWJXqMgeOPtj3y88A5A@mail.gmail.com>
References: <4F7B52D8.101@fb.com>
	<20120403215832.0520f93d@pyramind.ukuu.org.uk>
	<20120409164759.GA8800@kroah.com>
	<CABE8wwsHZLiihEReRQwkk+SufkmBw2W4n-WibQgS-rEOnKNGMA@mail.gmail.com>
	<20120409174823.GA31394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga12.intel.com ([143.182.124.36]:24250 "EHLO
	azsmga102.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753383Ab2DIR7H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Apr 2012 13:59:07 -0400
Received: by bkcjm19 with SMTP id jm19so3460633bkc.25
        for <linux-serial@vger.kernel.org>; Mon, 09 Apr 2012 10:59:04 -0700 (PDT)
In-Reply-To: <20120409174823.GA31394@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, sudhakar <sudhakar@fb.com>, linux-serial@vger.kernel.org, alan@linux.intel.com, nhan.h.mai@intel.com, linux-kernel@vger.kernel.org

On Mon, Apr 9, 2012 at 10:48 AM, Greg KH <gregkh@linuxfoundation.org> w=
rote:
> On Mon, Apr 09, 2012 at 09:53:47AM -0700, Williams, Dan J wrote:
>> On Mon, Apr 9, 2012 at 9:47 AM, Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>> > On Tue, Apr 03, 2012 at 09:58:32PM +0100, Alan Cox wrote:
>> >> On Tue, 3 Apr 2012 12:43:20 -0700
>> >> sudhakar <sudhakar@fb.com> wrote:
>> >>
>> >> >
>> >> > From: Sudhakar Mamillapalli <sudhakar@fb.com>
>> >> >
>> >> >
>> >> > The following commits don't completely fix the KT serial missin=
g
>> >> > interrupt problems. =A0So they have been replaced instead by
>> >> > enabling serial backup timer. =A0The iir-once + msi tried appro=
ach tried
>> >> > to enforce one read of the iir per THRE event, but its defeated=
 by any
>> >> > other event occurring at the wrong time, particularly MSR event=
s.
>> >> >
>> >> > 448ac15 serial/8250_pci: setup-quirk workaround for the kt seri=
al controller
>> >> > e86ff4a serial/8250_pci: init-quirk msi support for kt serial c=
ontroller
>> >>
>> >> These are already in tree. If you are reversing them and adding a
>> >> different fix then please post the series as
>> >>
>> >> - two revert patches exactly reverting the two commits
>> >> - a follow on patch or two adding the replacement
>> >>
>> >> That makes it much easier to review and much more obvious. It als=
o helps
>> >> make testing simpler.
>> >
>> > I agree, Sudhakar, can you please redo these 2 patches?
>> >
>>
>> Hi Greg,
>>
>> This was in the series:
>>
>> [PATCH 0/6] rework quirks for the "kt" serial port [1]
>>
>> ...but I have just noticed it collides with current git, and I also
>> need to address Stephen's comments for Tegra. =A0Expect a v2 shortly=
=2E
>
> Ok, thanks. =A0Note, I just applied the first 3 to go to Linus soon, =
those
> didn't need to be reworked, right?
>

Correct, those were ready to go.  Thanks!

--
Dan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
