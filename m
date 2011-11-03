From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH] serial/8250_pci: add a quirk for the kt serial controller
Date: Thu, 3 Nov 2011 09:34:12 -0700
Message-ID: <CABE8wwv4sQBRrG77sgVjUCBb1qXP1LUw=nkVwtU5TynWoQegUA@mail.gmail.com>
References: <20111023222711.22713.11434.stgit@localhost6.localdomain6>
	<20111025022852.GB32457@kroah.com>
	<1319573794.9320.15.camel@dwillia2-mobl>
	<20111025205106.GD7234@suse.de>
	<CABE8wwugFuNUstAFxKGLyZthAk+Cb9MN3kQFDr-vN08pdsMoRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49602 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933803Ab1KCQeO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Nov 2011 12:34:14 -0400
In-Reply-To: <CABE8wwugFuNUstAFxKGLyZthAk+Cb9MN3kQFDr-vN08pdsMoRA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Greg KH <greg@kroah.com>, Nhan H Mai <nhan.h.mai@intel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@linux.intel.com

On Tue, Oct 25, 2011 at 3:52 PM, Williams, Dan J
<dan.j.williams@intel.com> wrote:
> On Tue, Oct 25, 2011 at 1:51 PM, Greg KH <gregkh@suse.de> wrote:
>> On Tue, Oct 25, 2011 at 01:16:34PM -0700, Dan Williams wrote:
>>> From: Dan Williams <dan.j.williams@intel.com>
>>> Date: Sun, 23 Oct 2011 15:06:24 -0700
>>> Subject: [PATCH v2] serial/8250_pci: add a quirk for the kt serial =
controller
>>>
>>> Workaround dropped notifications in the iir register. =A0Prevent re=
ads
>>> coincident with new interrupt notifications by reading the iir at m=
ost
>>> once per interrupt.
>>>
>>> Reported-by: Nhan H Mai <nhan.h.mai@intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>
>> Much better.
>>
>> But.
>>
>> Do you really think I can apply a patch that looks like this above? =
=A0I
>> have to edit the text of the email before I apply it.
>
> I don't doubt you get busted patches all the time, this isn't one.

=2E..except for the fact that it would have collided spectacularly with
the contents of tty.git staged for 3.2.  Sorry for the noise, will
resend.

--
Dan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
