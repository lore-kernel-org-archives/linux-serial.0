From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [RFC PATCH] pch_uart: Add eg20t_port lock field, avoid recursive
 spinlocks
Date: Mon, 18 Jun 2012 14:41:46 -0700
Message-ID: <4FDFA09A.4030405@linux.intel.com>
References: <8854635ac5471f8671b93c65e3663eb1cb204c9d.1338454156.git.dvhart@linux.intel.com> <CANKRQnhZErpvcsRW3ukNzY0_zv4x=5OzQ-sr+aeuxL63=tQ=4A@mail.gmail.com> <4FC90BAD.3080606@linux.intel.com> <4FCE8307.3050901@linux.intel.com> <CANKRQnj5mxHLprMt4VMMa7sCwLZb=PAktnVVD1MZVkkUG4eLoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64931 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753658Ab2FRVnE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 17:43:04 -0400
In-Reply-To: <CANKRQnj5mxHLprMt4VMMa7sCwLZb=PAktnVVD1MZVkkUG4eLoA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org



On 06/05/2012 04:48 PM, Tomoya MORINAGA wrote:
> On Wed, Jun 6, 2012 at 7:07 AM, Darren Hart <dvhart@linux.intel.com> wrote:
>> Are there still concerns about the additional lock? I'll resend V2
>> tomorrow with the single whitespace fix if I don't hear anything back today.
> 
> I understand your saying. Looks good.
> However, I am not expert of linux-uart core system.
> So, I'd like UART maintainer to give us your opinion.

Greg, Alan,

any concerns with the locking approach I've adopted in the patch?

Thanks,

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel


