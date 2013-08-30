From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] tty: ar933x_uart: add device tree support and binding
 documentation
Date: Fri, 30 Aug 2013 14:13:27 -0700
Message-ID: <20130830211327.GA30138@kroah.com>
References: <1377769695-27397-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49704 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab3H3VLC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 30 Aug 2013 17:11:02 -0400
Content-Disposition: inline
In-Reply-To: <1377769695-27397-1-git-send-email-juhosg@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Aug 29, 2013 at 11:48:15AM +0200, Gabor Juhos wrote:
> Modify the probe routine to get the port line number
> from device tree if the 'of_node' is populated in the
> platform device. The driver can be built as module,
> thus add an OF specific module device table as well
> to support module auto loading.
> 
> This makes it possible to use the driver for AR9330
> UART devices specified in device tree.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
> Changes since v1:
>   - move the doc from bindings/tty/serial to bindings/serial
> 
> The patch is agains the 'tty-next' branch of the
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tree

No it isn't, it fails to apply here :(
