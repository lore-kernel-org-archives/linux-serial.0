From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] xilinx ps uart: Adding a kernel parameter for the
 number of xilinx ps uarts
Date: Mon, 22 May 2017 19:26:36 +0100
Message-ID: <20170522192636.5b578d89@alans-desktop>
References: <20170520022154.6766-1-kernel.development@povil.us>
 <20170520172008.5a979e8a@alans-desktop>
 <517d864d-d230-3abc-eb3c-4b628dc4625f@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <517d864d-d230-3abc-eb3c-4b628dc4625f@xilinx.com>
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
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Sam Povilus <kernel.development@povil.us>, soren.brinkmann@xilinx.com, linux-serial@vger.kernel.org, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

> We have in soc vendor tree similar patch but the reason is different.
> 
>     tty: serial: Added a CONFIG_SERIAL_XILINX_NR_UARTS option.
> 
>     This patch Adds CONFIG_SERIAL_XILINX_NR_UARTS option to allow
>     the user to provide the Max number of uart ports information.
>     If multiple cards (or) PL UARTS are present, the default limit
>     of 2 ports should be increased.
> 
> I haven't checked all drivers but in our case we have added this as
> quick fix for scenarios where you use serial aliases where alias is
> pointed to serial2 or more.
> In cdns_uart_init() cdns_uart_uart_driver is passed which contains .nr
> which is required to be passed.
> 
> What's the best driver to look at dynamic allocation?

So there are quite a few that dynamically allocate the objects as they
are enumerated (eg max3100), but have a maximum set that is just pointers
(so for the max number of ports cheaper than the dynamic code)

The other question is why is it a CONFIG_ option. I'm assuming these
platforms are all ARM and in that case you could just pass the value in
the device tree, or hard code a safe maximum number of pointers to a
value which is the worst case and then install them as they are
enumerated.

There are lots of options better than breaking the "one kernel many
platforms" model.

Alan
