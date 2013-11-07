From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] n_tty: Ensure reader restarts worker for next reader
Date: Thu, 07 Nov 2013 15:01:57 -0500
Message-ID: <527BF1B5.20803@hurleysoftware.com>
References: <20131017211236.GA6155@kroah.com> <1383850796-24300-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:51685 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752711Ab3KGUCL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 7 Nov 2013 15:02:11 -0500
In-Reply-To: <1383850796-24300-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Mikael Pettersson <mikpelinux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, stable@vger.kernel.org

On 11/07/2013 01:59 PM, Peter Hurley wrote:
> A departing reader must restart a flush_to_ldisc() worker _before_
> the next reader enters the read loop; this is to avoid the new reader
> concluding no more i/o is available and prematurely exiting, when the
> old reader simply hasn't re-started the worker yet.
>
> Cc: stable@kernel.org # 3.12
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

Greg,

I fluffed the stable cc:  Please pick this up for 3.12.1.

Regards,
Peter Hurley

