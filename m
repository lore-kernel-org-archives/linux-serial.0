From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] 8250_pci: Replace commits 448ac154 and e86ff4a
Date: Tue, 3 Apr 2012 13:09:20 -0700
Message-ID: <CABE8wwsdA7cXG=3rFYxa6v9g1jYpNg8Mq3+JyboRyTcBSvJVNA@mail.gmail.com>
References: <4F7B52D8.101@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga12.intel.com ([143.182.124.36]:38912 "EHLO
	azsmga102.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753352Ab2DCUJW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Apr 2012 16:09:22 -0400
Received: by iage36 with SMTP id e36so131344iag.25
        for <linux-serial@vger.kernel.org>; Tue, 03 Apr 2012 13:09:20 -0700 (PDT)
In-Reply-To: <4F7B52D8.101@fb.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: sudhakar <sudhakar@fb.com>
Cc: linux-serial@vger.kernel.org, alan@linux.intel.com, gregkh@linuxfoundation.org, nhan.h.mai@intel.com, linux-kernel@vger.kernel.org

On Tue, Apr 3, 2012 at 12:43 PM, sudhakar <sudhakar@fb.com> wrote:
>
> From: Sudhakar Mamillapalli <sudhakar@fb.com>
>
>
> The following commits don't completely fix the KT serial missing
> interrupt problems. =A0So they have been replaced instead by
> enabling serial backup timer. =A0The iir-once + msi tried approach tr=
ied
> to enforce one read of the iir per THRE event, but its defeated by an=
y
> other event occurring at the wrong time, particularly MSR events.
>
> 448ac15 serial/8250_pci: setup-quirk workaround for the kt serial con=
troller
> e86ff4a serial/8250_pci: init-quirk msi support for kt serial control=
ler
>
> Signed-off-by: Sudhakar Mamillapalli <sudhakar@fb.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Nhan H Mai <nhan.h.mai@intel.com>

Just a note that this should also be tagged for 3.3-stable since the
msi setup hack in e86ff4a breaks suspend/resume like this:

[  365.250523] sysfs: cannot create duplicate filename
'/devices/pci0000:00/0000:00:16.3/msi_irqs'
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
