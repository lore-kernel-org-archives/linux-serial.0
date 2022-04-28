Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA9AC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 28 Apr 2022 17:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiD1RFP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Apr 2022 13:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiD1RFP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Apr 2022 13:05:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023A0B820E
        for <linux-serial@vger.kernel.org>; Thu, 28 Apr 2022 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651165320; x=1682701320;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=b1hGQVbBio8IyozF7xktqSx+uh3Qj9IMgV1DeSLuid8=;
  b=dAWSMUxGt/8PuD6mbx10L3+/KQPSrM/qmaEv9NlMW/xCrp2evBKMLsZV
   3y0jy9WIUwXNdSNlJTTm6hKY5meJCeo1Y5d3D0WKuR4Qa8LJNBpZb2wE5
   jOWOWFwZWY3hNcOfBBJaxgg+pzRWn77v6hlUufKjSD/RuhUEjXYyuU9TX
   W7wbrm8gkkOnNYNtCSYr/A33e86ZwgSqZzKKxEe73Ld8w0BTi/btNxgJv
   bszflsKyn20ehTpIAhsXa2pA2Ezi2voUTyDAt+FoeHWbhSzi70dUoIK0q
   ZlrSKx3Lm/gTFdehSBHCqW5sMNdsWkTpqmtjIK+BNVHADnOD6KtpOlWsT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="246910400"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="246910400"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 10:01:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="581484171"
Received: from yawentax-mobl.ger.corp.intel.com ([10.249.32.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 10:01:44 -0700
Date:   Thu, 28 Apr 2022 20:01:28 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Nuno_Gon=E7alves?= <nunojpg@gmail.com>
cc:     linux-serial <linux-serial@vger.kernel.org>
Subject: Re: pl011 (Raspberry Pi) crash
In-Reply-To: <CAEXMXLR_4=UcGCHJPbFj_U1kbshFj=p00TOHNHcBv8bCCcis=Q@mail.gmail.com>
Message-ID: <bee66d7e-9e3f-fc82-5e4c-6f25abd0772d@linux.intel.com>
References: <CAEXMXLR_4=UcGCHJPbFj_U1kbshFj=p00TOHNHcBv8bCCcis=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-568064945-1651165213=:1945"
Content-ID: <d1fc77bb-f415-4fb2-fcbc-309afc2c1c5a@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-568064945-1651165213=:1945
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <788b8023-5bf7-5077-9317-28be16298e7@linux.intel.com>

On Thu, 28 Apr 2022, Nuno Gonçalves wrote:

> I started to use the mainline recently for the Raspberry Pi and get
> often this crash. I get it rarely and also don't have a history with
> previous versions, so it's hard to bisect this.
> 
> Got this with 5.18.0-rc4 also.
> 
> Port is pl011, with hardware flow control and baud at 2Mbps.
> 
> # [ 2742.199002] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [ 2742.207997] Mem abort info:
> [ 2742.210880] ESR = 0x86000005
> [ 2742.214024] EC = 0x21: IABT (current EL), IL = 32 bits
> [ 2742.219456] SET = 0, FnV = 0
> [ 2742.222583] EA = 0, S1PTW = 0
> [ 2742.225802] FSC = 0x05: level 1 translation fault
> [ 2742.230803] user pgtable: 4k pages, 39-bit VAs, pgdp=00000000045d0000
> [ 2742.237429] [0000000000000000] pgd=0000000000000000,
> p4d=0000000000000000, pud=0000000000000000
> [ 2742.246339] Internal error: Oops: 86000005 [#1] PREEMPT SMP
> [ 2742.252016] CPU: 3 PID: 192 Comm: kworker/u8:3 Not tainted 5.18.0-rc3 #1
> [ 2742.258828] Hardware name: Raspberry Pi Compute Module 3 IO board V3.0 (DT)
> [ 2742.265896] Workqueue: events_unbound flush_to_ldisc
> [ 2742.270959] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 2742.278032] pc : 0x0
> [ 2742.280253] lr : uart_throttle+0x94/0x160
> [ 2742.284331] sp : ffffffc0095abbd0
> [ 2742.287692] x29: ffffffc0095abbd0 x28: 0000000000000000 x27: 0000000000000077
> [ 2742.294953] x26: ffffff800261d400 x25: ffffffc009241000 x24: 0000000000000000
> [ 2742.302214] x23: 0000000000000008 x22: ffffff8002635610 x21: ffffff8001fb9080
> [ 2742.309476] x20: ffffff800261d400 x19: 0000000000000024 x18: 000000457a869a76
> [ 2742.316736] x17: 0000000000000001 x16: 0000000000000001 x15: 0014070c74d6ecfa
> [ 2742.323994] x14: 00140abfb6d3354a x13: ffffffc00892c468 x12: 00000000fa83b2da
> [ 2742.331256] x11: 00000000000002b6 x10: 0000000000001a40 x9 : ffffffc00854b374
> [ 2742.338517] x8 : fefefefefefefeff x7 : 0000000000000000 x6 : 0000000000000000
> [ 2742.345775] x5 : 0000000000000001 x4 : ffffff80025b0000 x3 : 000000000000000d
> [ 2742.353034] x2 : 0000000000000004 x1 : 0000000000000000 x0 : ffffff8001fb9080
> [ 2742.360294] Call trace:
> [ 2742.362773] 0x0
> [ 2742.364642] tty_throttle_safe+0xb4/0xe0
> [ 2742.368636] n_tty_receive_buf_common+0x760/0x1350
> [ 2742.373509] n_tty_receive_buf2+0x20/0x30
> [ 2742.377582] tty_ldisc_receive_buf+0x2c/0x80
> [ 2742.381921] tty_port_default_receive_buf+0x50/0x90
> [ 2742.386879] flush_to_ldisc+0xfc/0x140
> [ 2742.390689] process_one_work+0x1dc/0x450
> [ 2742.394768] worker_thread+0x154/0x450
> [ 2742.398579] kthread+0x100/0x110
> [ 2742.401859] ret_from_fork+0x10/0x20
> [ 2742.405504] Code: bad PC value
> [ 2742.408607] ---[ end trace 0000000000000000 ]---

I wonder on what basis uart_throttle() assumes that .throttle is non-NULL 
in uart_ops? ...Perhaps I'm missing something but I cannot find anything 
that would guarantee it (and pl011 is among the drivers that don't seem 
to set it).

-- 
 i.
--8323329-568064945-1651165213=:1945--
