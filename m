From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH] usb/serial: Remove unnecessary check for console
Date: Sat, 23 Feb 2013 16:57:08 +0100
Message-ID: <20130223155708.GA30855@localhost>
References: <1361632295-5863-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:37850 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab3BWP56 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 23 Feb 2013 10:57:58 -0500
Content-Disposition: inline
In-Reply-To: <1361632295-5863-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Sat, Feb 23, 2013 at 10:11:35AM -0500, Peter Hurley wrote:
> The tty port ops shutdown() routine is not called for console ports;
> remove extra check.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

Acked-by: Johan Hovold <jhovold@gmail.com>
