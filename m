From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH LINUX v3 07/10] tty: xuartps: Acquire port lock for
 shutdown
Date: Sat, 5 Dec 2015 12:23:46 -0500
Message-ID: <56631DA2.5050402@hurleysoftware.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-8-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448161172-19717-8-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> Shutting down the UART port can happen while console operations are in
> progress. Holding the port lock serializes these operations and avoids
> the UART HW to be disabled in the middle of console prints.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
