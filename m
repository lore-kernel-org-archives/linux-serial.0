From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH LINUX v3 03/10] tty: xuartps: Don't consider circular
 buffer when enabling transmitter
Date: Sat, 5 Dec 2015 12:17:59 -0500
Message-ID: <56631C47.6010905@hurleysoftware.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-4-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448161172-19717-4-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> Restarting the transmitter even if the circ buffer is empty may be
> necessary to push out remaining data when the port is restarted after
> being stopped.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
