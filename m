From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] serial: 8250: 8250_core: Use dev_name() during
 request_irq()
Date: Thu, 9 Mar 2017 20:07:24 +0530
Message-ID: <435d73f7-d057-631b-8d00-8639d764414f@ti.com>
References: <20170308121943.29340-1-vigneshr@ti.com>
 <20170308123417.GA3981@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170308123417.GA3981@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hi,

On Wednesday 08 March 2017 06:04 PM, Greg Kroah-Hartman wrote:
> On Wed, Mar 08, 2017 at 05:49:43PM +0530, Vignesh R wrote:
>> Passing "serial" as name during request_irq() results in all serial port
>> irqs have same name. This does not help much to easily identify which
>> irq belongs to which serial port instance. Therefore pass dev_name()
>> during request_irq() so that better identifiable name is listed for
>> serial ports in cat /proc/interrupts output.
>>
>> Output of cat /proc/interrupts
>> Before this patch:
>>  26:        689          0     GICv2 309 Edge      serial
>> After this patch:
>>  26:        696          0     GICv2 309 Edge      2530c00.serial
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
> I need a "full" name here, unless you really do sign legal documents
> with just one letter as a last/sur-name?
> 

Its perfectly alright not to expand surname here in India. FWIW, my ID
cards also have the same name.
I have been contributing to the kernel with above Signed-off-by line in
the past and would want to continue to use the same.

-- 
Regards
Vignesh
