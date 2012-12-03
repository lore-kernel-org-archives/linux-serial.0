From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCHv2 3/5] serial: 8250_dw: Map IO memory
Date: Mon, 3 Dec 2012 11:47:47 +0000
Message-ID: <20121203114747.17db30bc@bob.linux.org.uk>
References: <1354533479-27306-1-git-send-email-heikki.krogerus@linux.intel.com>
	<1354533479-27306-4-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1392 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab2LCLpS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Dec 2012 06:45:18 -0500
In-Reply-To: <1354533479-27306-4-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon,  3 Dec 2012 13:17:57 +0200
Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:

> This needs to be done in order to later access the
> Designware specific registers.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Series Acked-by: Alan Cox <alan@linux.intel.com>
