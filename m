From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v3 1/3] serial: sh-sci: Add OF support
Date: Wed, 27 Feb 2013 17:07:42 +0900
Message-ID: <20130227080742.GB21690@linux-sh.org>
References: <1361898208-6683-1-git-send-email-hechtb+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:55107 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282Ab3B0IHq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Feb 2013 03:07:46 -0500
Content-Disposition: inline
In-Reply-To: <1361898208-6683-1-git-send-email-hechtb+renesas@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org

On Tue, Feb 26, 2013 at 11:03:26AM -0600, Bastian Hecht wrote:
> We add the capabilty to probe Renesas SCI devices using Device Tree setup.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
> v3:
> - add remaining register layouts to bindings
> - remove register set mapping sci_regtype_modes[]
> - adapt renesas,regtype probing
> 
> - add enums SCBRR_ALGO_INVALID and SCBRR_NR_ALGOS
> - check renesas,scbrr-algo-id boundaries using new enums
> 
>  .../bindings/tty/serial/renesas,sci-serial.txt     |   53 ++++++++
>  drivers/tty/serial/sh-sci.c                        |  126 +++++++++++++++++++-
>  include/linux/serial_sci.h                         |    4 +
>  3 files changed, 179 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
> 
Looks good to me.

Reviewed-by: Paul Mundt <lethal@linux-sh.org>
