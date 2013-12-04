From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Convert termios to RCU (was Re: [PATCH tty-next 0/4] tty: Fix
 ^C echo)
Date: Tue, 03 Dec 2013 19:14:16 -0500
Message-ID: <529E73D8.1000809@hurleysoftware.com>
References: <1386018725-4781-1-git-send-email-peter@hurleysoftware.com>	<20131203000116.0d512b59@alan.etchedpixels.co.uk>	<529D4E58.9020101@hurleysoftware.com> <20131203142011.371067ea@alan.etchedpixels.co.uk> <529E138C.4010503@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:55647 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754230Ab3LDAOS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Dec 2013 19:14:18 -0500
In-Reply-To: <529E138C.4010503@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 12/03/2013 12:23 PM, Peter Hurley wrote:
> On 12/03/2013 09:20 AM, One Thousand Gnomes wrote:
>> As a PS: I think the termios is probably an RCU problem. The semaphore
>> seemed to make sense when I did it, but in hindsight I think I made the
>> wrong call.

Unfortunately, not without overhauling the console_lock().


