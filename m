From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH LINUX v3 02/10] tty: xuartps: Use spinlock to serialize HW
 access
Date: Sat, 5 Dec 2015 12:05:27 -0500
Message-ID: <56631957.3050302@hurleysoftware.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-3-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448161172-19717-3-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> Instead of disabling the IRQ, use the spin lock to serialize accesses to
> the HW. This protects the driver from interference of non-IRQ callbacks
> with each other and makes the driver more consistent in its
> serialization method.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
