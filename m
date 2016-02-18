From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2] serial: xuartps: Enable OF earlycon support
Date: Thu, 18 Feb 2016 08:50:56 -0800
Message-ID: <56C5F670.50005@hurleysoftware.com>
References: <09f2c419994281fca7968142e52d969542370d1c.1455782238.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <09f2c419994281fca7968142e52d969542370d1c.1455782238.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, monstr@monstr.eu, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On 02/17/2016 11:57 PM, Michal Simek wrote:
> Support early console setup via DT for all listed compatible strings.
> Remove EARLYCON_DECLARE which was done by:
> "Use common framework for earlycon declarations"
> (sha1: 2eaa790989e03900298ad24f77f1086dbbc1aebd)
> when OF_EARLYCON_DECLARE is defined.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
