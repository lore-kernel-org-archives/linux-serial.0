From: Benjamin Krill <ben@codiert.org>
Subject: Re: [PATCH] Fix wrong register read address and add interrupt acknowledge.
Date: Fri, 8 May 2009 09:50:36 +0200
Message-ID: <20090508075036.GX14906@codiert.org>
References: <20090505191116.GA7267@codiert.org> <ed82fe3e0905051224j30a54ef3s3d5e6c88987ea65a@mail.gmail.com> <20090505230919.GE14017@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cursor.subgra.de ([78.46.252.50]:55635 "EHLO cursor.subgra.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582AbZEHHvO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 May 2009 03:51:14 -0400
Content-Disposition: inline
In-Reply-To: <20090505230919.GE14017@zod.rchland.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org, arnd@arndb.de, linux-serial@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>

* Josh Boyer | 2009-05-05 19:09:19 [-0400]:

>On Tue, May 05, 2009 at 02:24:04PM -0500, Timur Tabi wrote:
>>On Tue, May 5, 2009 at 2:11 PM, Benjamin Krill <ben@codiert.org> wrote:
>
>That is quite true.  Although resending the patch just for that seems overkill.
>The maintainer can edit the summary rather easily.

Ben, could you please merge this patch in your next tree?


cheers
  ben
