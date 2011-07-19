From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: serial/pch_uart: AT command behavior
Date: Tue, 19 Jul 2011 10:06:13 +0100
Message-ID: <20110719100613.21b9eb32@lxorguk.ukuu.org.uk>
References: <1308736219-19975-1-git-send-email-alexander.stein@systec-electronic.com>
	<4E02857C.1010304@dsn.okisemi.com>
	<4E2504FD.6090107@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49620 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752360Ab1GSJDh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Jul 2011 05:03:37 -0400
In-Reply-To: <4E2504FD.6090107@dsn.okisemi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, "toshiharu-linux@dsn.okisemi.com" <toshiharu-linux@dsn.okisemi.com>, "Ewe, Kok Howg" <kok.howg.ewe@intel.com>, "Wang, Qi" <qi.wang@intel.com>, "Wang, Yong Y" <yong.y.wang@intel.com>, "Clark, Joel" <joel.clark@intel.com>

On Tue, 19 Jul 2011 13:15:57 +0900
Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com> wrote:

> Hi,
> 
> I have a question for UART driver AT command behavior.
> When installing pch_uart, AT command "AT+GCAP^M" are sent for 4 times.
> This command is sent first install only.
> (After the above, removing pch_uart and installing pch_uart again,
> this command is not sent.)
> 
> Let me know the behavior is normal or not ?

As your distribution, it isn't the kernel.
