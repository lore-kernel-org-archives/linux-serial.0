Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08088C3DA7D
	for <linux-serial@archiver.kernel.org>; Thu,  5 Jan 2023 08:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjAEIs3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Jan 2023 03:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjAEIs1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Jan 2023 03:48:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255A9F5BF;
        Thu,  5 Jan 2023 00:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672908507; x=1704444507;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ru9EM3IJ4/m8HQSwKKupRDnr5KCI+m5bAzN/djFn5t8=;
  b=drueg52Sxsj76b0NJBEAJ6BIt9++mbPIlViJ8UJOpIyq43YvlyAPCzAP
   zHOHYIraXnXU/zX4Thiec2u2ios6RaJOT3yOzYn7AWvyg5Yo7dksZFNxo
   kJFCtpkXn5oFazde8LUejrwvdWbPYereN1h90DJA1BtJ7pGVp5OBd4Yyc
   +y/Z0HzfX9Tv8rjKjfL5yFiXmzv7D+14ciuconfIejE61x4B0qMgWz3dG
   d9QZL3ccH7YH8MvLOsfTDhX+Xz7MQVdbpAosEXxRGQUQRZK9EjoAM985X
   P5j+o32qDMIlbnTbb4QqdlXu01szXWEScLUBRPR96pz/qq8Qv0uy2ZNv1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="319860077"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="319860077"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 00:48:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="797843857"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="797843857"
Received: from khaunx-mobl1.ger.corp.intel.com ([10.252.35.181])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 00:48:25 -0800
Date:   Thu, 5 Jan 2023 10:48:19 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 05/10] serial: Convert uart_{,port_}startup() init_hw
 param to bool
In-Reply-To: <7ecfd7bc-8148-cadc-a58a-a2813b1862ac@kernel.org>
Message-ID: <a92e254e-87db-3e7-8323-5bf43326adb1@linux.intel.com>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com> <20230104151531.73994-6-ilpo.jarvinen@linux.intel.com> <7ecfd7bc-8148-cadc-a58a-a2813b1862ac@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-77325294-1672908507=:1832"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-77325294-1672908507=:1832
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 5 Jan 2023, Jiri Slaby wrote:

> On 04. 01. 23, 16:15, Ilpo Järvinen wrote:
> > Convert init_hw parameter in uart_startup() and uart_port_startup() to
> > bool as code treats them like bool.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >   drivers/tty/serial/serial_core.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/serial_core.c
> > b/drivers/tty/serial/serial_core.c
> > index c881fefa3d97..a0260a40bdb9 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -181,8 +181,7 @@ static void uart_port_dtr_rts(struct uart_port *uport,
> > int raise)
> >    * Startup the port.  This will be called once per open.  All calls
> >    * will be serialised by the per-port mutex.
> >    */
> > -static int uart_port_startup(struct tty_struct *tty, struct uart_state
> > *state,
> > -		int init_hw)
> > +static int uart_port_startup(struct tty_struct *tty, struct uart_state
> > *state, bool init_hw)
> >   {
> >   	struct uart_port *uport = uart_port_check(state);
> >   	unsigned long flags;
> > @@ -253,8 +252,7 @@ static int uart_port_startup(struct tty_struct *tty,
> > struct uart_state *state,
> >   	return retval;
> >   }
> >   -static int uart_startup(struct tty_struct *tty, struct uart_state *state,
> > -		int init_hw)
> > +static int uart_startup(struct tty_struct *tty, struct uart_state *state,
> > bool init_hw)
> 
> You made both of them over 80 characters/line. Why?

I've started to use 100 chars/line especially for things which are 
naturally long such as these. But I can change that back.

-- 
 i.

--8323329-77325294-1672908507=:1832--
