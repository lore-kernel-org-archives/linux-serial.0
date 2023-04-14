Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABFFC77B6E
	for <linux-serial@archiver.kernel.org>; Fri, 14 Apr 2023 12:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDNMKT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNMKS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Apr 2023 08:10:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A16F3
        for <linux-serial@vger.kernel.org>; Fri, 14 Apr 2023 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681474216; x=1713010216;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bw3h+c/kTOAii5Dy2cxyPr+7KAdzQlB8ZwsycyME5U0=;
  b=F2jgB6oRMFJ4bksjGJ3ylKuBdwkYzbgxTSD6u5rbQ2lhXm4p3fvOob4h
   J4eixKheWTIJ6sDWQYZVG2FzUcFpekMUiiTn3x1zVFXFZhde/8F1Meqqj
   t7+0KylBT1iqNqR1a6ylrTbegTHLCJB6bB6W3ZiQxKUbYzZ+ucnVSt8eR
   mLeKyUuTUVzk/5+4HnNlP0Czzork3crzG+0+Rh9QbMmdKezpLiJuLOUCk
   Z2GNxU0/QObWT6FQWUElu0wE+V/vPYAD0I+S0y2Fhufnf38Xlc70rZgC4
   bW8k1MNN6EWrRacSDl/TwvM2ZEfdElpmccErzLcvXApNXPFtoauUf/Nus
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372312921"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="372312921"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 05:10:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="640085755"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="640085755"
Received: from smiokx-mobl.amr.corp.intel.com ([10.252.57.49])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 05:10:14 -0700
Date:   Fri, 14 Apr 2023 15:10:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     qianfan <qianfanguijin@163.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: serial8250: can not change baudrate while the controller is
 busy
In-Reply-To: <289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com>
Message-ID: <ab524eb-da1d-bf74-6d73-2defb7f7118@linux.intel.com>
References: <289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, 14 Apr 2023, qianfan wrote:

> Hi:
> 
> My custom board is based on allwinner R40, the uart is compatibled with
> serial8250. Based on it's datasheet:
> 
> > When TX transmit data, or RX receives data, or TX FIFO is not empty, then
> the
> > BUSY flag bit can be set to 1 by hardware, which indicates the UART
> > controller is busy.
> 
> We cannot write LCR and DLL to update UART params such as baudrate and partity
> while the UART is busy, however `serial8250_do_set_termios` is a void
> function,
> the upper level always assume the uart params is updated.
> 
> The upper level `uart_set_termios` do noting if ktermios params is not
> changed,
> it will not update when the user space program running tcsetattr set a same
> baudrate again.
>
> So we can not fix the baudrate when
> `serial8250_do_set_termios`
> failed.
> 
> Allwinner R40's datasheet provided a way for this case.
> 
> > CHCFG_AT_BUSY(configure at busy): Enable the bit, software can also set UART
> > controller when UART is busy, such as the LCR, DLH, DLL register.
> > CHANGE_UPDATE(change update): If CHCFG_AT_BUSY is enabled, and CHANGE_UPDATE
> > is written to 1, the configuration of UART controller can be updated.
> > After completed update, the bit is cleared to 0 automatically.
> 
> I can't know this feature is expanded by allwinner, or it is a common
> functiton
> of serial8250. Perhaps the serial8250 driver need this.

tcsetattr() can be given a flag which enforces TX empty condition before 
core calls into the lower layer HW set_termios function. Would that be 
enough to solve the case you're interested in?

Obviously, nothing can prevent Rx from occuring as it's not under local 
UART's control (e.g. a busy flag check would still be racy). But does 
writing those registers actually break something or just corrupts the 
character under Tx/Rx (which can be handled by flushing)?

-- 
 i.

