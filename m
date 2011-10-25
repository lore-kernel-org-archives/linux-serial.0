From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH] serial/8250_pci: add a quirk for the kt serial controller
Date: Tue, 25 Oct 2011 15:52:20 -0700
Message-ID: <CABE8wwugFuNUstAFxKGLyZthAk+Cb9MN3kQFDr-vN08pdsMoRA@mail.gmail.com>
References: <20111023222711.22713.11434.stgit@localhost6.localdomain6>
	<20111025022852.GB32457@kroah.com>
	<1319573794.9320.15.camel@dwillia2-mobl>
	<20111025205106.GD7234@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50325 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821Ab1JYWwe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Oct 2011 18:52:34 -0400
In-Reply-To: <20111025205106.GD7234@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Greg KH <greg@kroah.com>, Nhan H Mai <nhan.h.mai@intel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@linux.intel.com

On Tue, Oct 25, 2011 at 1:51 PM, Greg KH <gregkh@suse.de> wrote:
> On Tue, Oct 25, 2011 at 01:16:34PM -0700, Dan Williams wrote:
>> From: Dan Williams <dan.j.williams@intel.com>
>> Date: Sun, 23 Oct 2011 15:06:24 -0700
>> Subject: [PATCH v2] serial/8250_pci: add a quirk for the kt serial c=
ontroller
>>
>> Workaround dropped notifications in the iir register. =A0Prevent rea=
ds
>> coincident with new interrupt notifications by reading the iir at mo=
st
>> once per interrupt.
>>
>> Reported-by: Nhan H Mai <nhan.h.mai@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Much better.
>
> But.
>
> Do you really think I can apply a patch that looks like this above? =A0=
I
> have to edit the text of the email before I apply it.

I don't doubt you get busted patches all the time, this isn't one.
Double checked before and now triple checked that git am takes the
last occurrence of the From: Date: and Subject: headers and that my
mailer is not corrupting the patch.

I have no problem resending to fit into your workflow, but I expect
"git am" will do the right thing with this mail.

--
Dan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
