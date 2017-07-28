From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/4] serial: uartps: Dynamic allocation
Date: Fri, 28 Jul 2017 19:39:52 +0100
Message-ID: <20170728193952.1f85073f@alans-desktop>
References: <cover.1500629544.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1500629544.git.michal.simek@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: monstr@monstr.eu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, =?UTF-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

On Fri, 21 Jul 2017 11:32:23 +0200
Michal Simek <michal.simek@xilinx.com> wrote:

> Hi Alan,
> 
> this is the initial version before next step which is move
> uart_register_driver to probe function.
> I was able to get rid of static array with uart_port structures.
> It was wired with console which is also fixed.
> And the next step is the most complicated one handle .nr in uart_driver
> structure in more generic way.
> 
> Thanks,
> Michal

Sorry for the delay been on jury service

Series

Reviewed-by: Alan Cox <alan@linux.intel.com>
