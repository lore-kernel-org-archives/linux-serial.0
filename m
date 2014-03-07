From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH RFC v2 09/11] ARM: multi_v7_defconfig: Adopt to UART
 driver renaming
Date: Fri, 7 Mar 2014 15:16:06 -0800
Message-ID: <726e4ba5-be0b-49d8-80f1-04cf05599ba4@TX2EHSMHS031.ehs.local>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394219614-3197-10-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394219614-3197-10-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Michal Simek <michal.simek@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2014-03-07 at 11:13AM -0800, Soren Brinkmann wrote:
> The Xilinx UARTPS driver has been renamed to Cadence UART.  Remove
> the stale Xilinx UARTPS config options and add Cadence UART instead.

This will also be dropped, since the corresponding renaming of config
symbol gets dropped.

	S=C3=B6ren
