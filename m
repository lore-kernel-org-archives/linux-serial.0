From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] serial: of_serial: Handle fifo-size property
Date: Mon, 25 Mar 2013 11:38:52 +0000
Message-ID: <201303251138.52425.arnd@arndb.de>
References: <1364211286-31611-1-git-send-email-heikki.krogerus@linux.intel.com> <1364211286-31611-3-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58670 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756436Ab3CYLi7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Mar 2013 07:38:59 -0400
In-Reply-To: <1364211286-31611-3-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ley Foon Tan <lftan@altera.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Monday 25 March 2013, Heikki Krogerus wrote:
> 
> This will reduce the need for extra types in 8250.c just
> in case the fifo size differs from the standard.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
