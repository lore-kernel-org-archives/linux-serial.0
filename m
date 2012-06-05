From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [RFC PATCH] pch_uart: Add eg20t_port lock field, avoid recursive spinlocks
Date: Wed, 6 Jun 2012 08:48:20 +0900
Message-ID: <CANKRQnj5mxHLprMt4VMMa7sCwLZb=PAktnVVD1MZVkkUG4eLoA@mail.gmail.com>
References: <8854635ac5471f8671b93c65e3663eb1cb204c9d.1338454156.git.dvhart@linux.intel.com>
	<CANKRQnhZErpvcsRW3ukNzY0_zv4x=5OzQ-sr+aeuxL63=tQ=4A@mail.gmail.com>
	<4FC90BAD.3080606@linux.intel.com>
	<4FCE8307.3050901@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FCE8307.3050901@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 6, 2012 at 7:07 AM, Darren Hart <dvhart@linux.intel.com> wrote:
> Are there still concerns about the additional lock? I'll resend V2
> tomorrow with the single whitespace fix if I don't hear anything back today.

I understand your saying. Looks good.
However, I am not expert of linux-uart core system.
So, I'd like UART maintainer to give us your opinion.

thanks.
tomoya
