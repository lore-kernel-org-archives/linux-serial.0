From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 2/2] pch_uart: Delete modem status interrupt enable code
Date: Tue, 1 Nov 2011 12:57:57 +0000
Message-ID: <20111101125757.4ef7f883@bob.linux.org.uk>
References: <1319697919-5623-1-git-send-email-tomoya-linux@dsn.lapis-semi.com>
	<1319697919-5623-2-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319697919-5623-2-git-send-email-tomoya-linux@dsn.lapis-semi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: linux-serial@vger.kernel.org

> (pch_uart device has auto hardware flow control function. So,
> pch_uart driver doesn't have to control modem status interrupt.)

This is true for flow control bits but not for incoming carrier detect ?

> This patch deletes the code.

> +	dev_info(priv->port.dev,
> +		"PCH UART : Modem status interrupt is not
> supported.\n"); }

dev_info seems wrong here. Does the user need to know this ?
