From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/2] tty/n_gsm: fix a bug in gsm_dlci_data_output
 (adaption = 2 case)
Date: Tue, 27 Sep 2011 11:58:04 +0100
Message-ID: <20110927115804.40ab56dc@bob.linux.org.uk>
References: <1316791376-4863-1-git-send-email-mikhail.kshevetskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:4537 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729Ab1I0Kt6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Sep 2011 06:49:58 -0400
In-Reply-To: <1316791376-4863-1-git-send-email-mikhail.kshevetskiy@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>
Cc: linux-serial@vger.kernel.org, gregkh@suse.de, linux-kernel@vger.kernel.org

On Fri, 23 Sep 2011 19:22:55 +0400
Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com> wrote:

> in adaption=2 case we should put 1 or 2 byte with modem status bits
> at the beginning of a buffer pointed by "dp". n_gsm use 1 byte case,
> so it allocate a buffer of len + 1 size. As result we should:
>   * put 1 byte of modem status bits
>   * increase data pointer
>   * put "len" bytes of data
> but actually we have:
>   * increase first byte with the value of modem status bits
>   * decrease "len"
>   * put orig_len - 1 bytes of data starting from the buffer beggining
> This is evidently wrong.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>

Acked-by: Alan Cox <alan@linux.intel.com>
