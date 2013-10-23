From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [GIT PATCH] TTY/Serial fixes for 3.12-rc4
Date: Wed, 23 Oct 2013 09:16:36 -0400
Message-ID: <5267CC34.1020700@hurleysoftware.com>
References: <20131005173403.GA4811@kroah.com> <CA+55aFzEtnOOB4yPbWg4tmvWTPjQL1_YsZks6wgpGimaQdOEtA@mail.gmail.com> <5250A74E.4070805@hurleysoftware.com> <5250C6CD.1040803@hurleysoftware.com> <20131017211236.GA6155@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:45525 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753752Ab3JWNQl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Oct 2013 09:16:41 -0400
In-Reply-To: <20131017211236.GA6155@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mikael Pettersson <mikpelinux@gmail.com>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

On 10/17/2013 05:12 PM, Greg KH wrote:
> On Sat, Oct 05, 2013 at 10:11:25PM -0400, Peter Hurley wrote:
>> On 10/05/2013 07:57 PM, Peter Hurley wrote:
>>
>> However, the atomic_read_lock exclusion needs to cover the
>> unconditional n_tty_set_room() when leaving n_tty_read() and
>> it doesn't. Thus, the departing reader fails to ensure the subsequent
>> reader has a running flush_to_ldisc() worker.
>>
>> Patch forthcoming.
>
> Did I miss this patch, or did it not come forth?

Sorry to go off-grid like that;  interrupt(life) happened.

I'm testing that patch now.

Regards,
Peter Hurley
