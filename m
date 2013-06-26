From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 2/8] pch_uart: Add uart_clk selection for the MinnowBoard
Date: Wed, 26 Jun 2013 09:25:49 +0200
Message-ID: <51CA977D.3050802@suse.cz>
References: <cover.1372211451.git.dvhart@linux.intel.com>   <6cc125b9eb85dd3cae4a2496fdb7f0d17b18f930.1372211451.git.dvhart@linux.intel.com>   <20130626023143.GB23320@kroah.com> <1372216578.8177.9.camel@envy.home>   <20130626033926.GA27165@kroah.com> <1372219125.8177.12.camel@envy.home>  <51CA8D91.6000708@suse.cz> <1372231162.8177.70.camel@envy.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:41927 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab3FZHZy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Jun 2013 03:25:54 -0400
In-Reply-To: <1372231162.8177.70.camel@envy.home>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, peter.p.waskiewicz.jr@intel.com, andriy.shevchenko@linux.intel.com, danders@circuitco.com, vishal.l.verma@intel.com, linux-serial@vger.kernel.org

On 06/26/2013 09:19 AM, Darren Hart wrote:
> You can't actually use this driver on 64 bit as there is no hardware,

Oh, so is this another candidate for adding dependson (X86_32 ||
COMPILE_TEST) as well as the other *_PCH options?

-- 
js
suse labs
