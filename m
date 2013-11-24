From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH tty-next 5/7] n_tty: Refactor input_available_p() by call
 site
Date: Sat, 23 Nov 2013 21:01:56 -0500
Message-ID: <52915E14.7000703@hurleysoftware.com>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>	<1385135965-4235-6-git-send-email-peter@hurleysoftware.com> <20131124002650.74902872@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:49482 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755708Ab3KXCCC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 23 Nov 2013 21:02:02 -0500
In-Reply-To: <20131124002650.74902872@alan.etchedpixels.co.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 11/23/2013 07:26 PM, One Thousand Gnomes wrote:
> On Fri, 22 Nov 2013 10:59:23 -0500
> Peter Hurley <peter@hurleysoftware.com> wrote:
>
>> Distinguish if caller is n_tty_poll() or n_tty_read(), and
>> set the read/wakeup threshold accordingly.
>>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>
> Doh ignore previous.. yes that patch is right.  I should pay attention to
> 0/7 8)

Maybe I should add more to the commit message from the cover letter
description ?

