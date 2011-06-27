From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCHv3 1/2] dt: document the of_serial bindings
Date: Mon, 27 Jun 2011 13:32:18 -0600
Message-ID: <20110627193218.GA20865@ponder.secretlab.ca>
References: <1309177954-8786-1-git-send-email-jamie@jamieiles.com>
 <201106271505.32296.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58039 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab1F0TcV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Jun 2011 15:32:21 -0400
Received: by pwj7 with SMTP id 7so3138496pwj.19
        for <linux-serial@vger.kernel.org>; Mon, 27 Jun 2011 12:32:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201106271505.32296.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Mon, Jun 27, 2011 at 03:05:32PM +0200, Arnd Bergmann wrote:
> On Monday 27 June 2011, Jamie Iles wrote:
> > The of_serial bindings can be used to register a number of serial
> > devices.  Document this binding with all of the others.
> > 
> > v3: remove device-type and clarify used-by-rtas
> > 
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Merged both patches, thanks.

g.

