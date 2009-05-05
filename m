From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Fix wrong register read address and add interrupt
	acknowledge.
Date: Tue, 5 May 2009 19:09:19 -0400
Message-ID: <20090505230919.GE14017@zod.rchland.ibm.com>
References: <20090505191116.GA7267@codiert.org> <ed82fe3e0905051224j30a54ef3s3d5e6c88987ea65a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:59841 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012AbZEEXK1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 May 2009 19:10:27 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n45N6ngE002467
	for <linux-serial@vger.kernel.org>; Tue, 5 May 2009 19:06:49 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n45NARvC138818
	for <linux-serial@vger.kernel.org>; Tue, 5 May 2009 19:10:27 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n45NARII025637
	for <linux-serial@vger.kernel.org>; Tue, 5 May 2009 19:10:27 -0400
Content-Disposition: inline
In-Reply-To: <ed82fe3e0905051224j30a54ef3s3d5e6c88987ea65a@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
Cc: Benjamin Krill <ben@codiert.org>, linuxppc-dev@ozlabs.org, arnd@arndb.de, linux-serial@vger.kernel.org

On Tue, May 05, 2009 at 02:24:04PM -0500, Timur Tabi wrote:
>On Tue, May 5, 2009 at 2:11 PM, Benjamin Krill <ben@codiert.org> wrote:
>> The receive interrupt routine checks the wrong register if the
>> receive fifo is empty. Further an explicit interrupt acknowledge
>> write is introduced. In some circumstances another interrupt was
>> issued.
>
>The one-line summary of your patch is too vague.  It should mention
>the name of the driver somehow.

That is quite true.  Although resending the patch just for that seems overkill.
The maintainer can edit the summary rather easily.

josh
