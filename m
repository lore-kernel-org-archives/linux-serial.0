From: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Subject: Re: [PATCH 2/2] pch_uart: Delete modem status interrupt enable code
Date: Thu, 10 Nov 2011 11:11:22 +0900
Message-ID: <4EBB32CA.5020206@dsn.lapis-semi.com>
References: <1319697919-5623-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>	<1319697919-5623-2-git-send-email-tomoya-linux@dsn.lapis-semi.com>	<20111101125757.4ef7f883@bob.linux.org.uk>	<4EB0DAB6.7000106@dsn.lapis-semi.com> <20111102110055.153d06c6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sm-d311v.smileserver.ne.jp ([203.211.202.206]:3216 "EHLO
	sm-d311v.smileserver.ne.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753542Ab1KJCLW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Nov 2011 21:11:22 -0500
In-Reply-To: <20111102110055.153d06c6@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com

Hi Alan,

(2011/11/02 20:00), Alan Cox wrote:
>> Called ".get_mctrl" function, other software can know incoming carrier
>> detection.
>> Or you mean a uart driver must detect incoming carrier with interrupt ?
>
> If a user opens a tty port which has no carrier signal then the open is
> supposed to block until the carrier is raised unless either clocal
> termios or O_NDELAY open flags are set.
>
> That usually means you need to take the carrier raise interrupt in order
> to wake out of open in this case.
>

I understand.
We need to add modem status interrupt processing.

Thanks,
-- 
tomoya
ROHM Co., Ltd.
