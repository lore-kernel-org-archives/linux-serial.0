From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] serial: uartps: Add the device_init_wakeup
Date: Mon, 17 Dec 2018 16:29:56 +0100
Message-ID: <333f4be8-a4ae-4276-e2ac-725d1ae4c9b0@xilinx.com>
References: <ec9fdbdf1c444dc60edfc75a31583630e76a9b72.1544016009.git.michal.simek@xilinx.com>
 <20181217151520.GA12453@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181217151520.GA12453@kroah.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>
Cc: monstr@monstr.eu, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 17. 12. 18 16:15, Greg Kroah-Hartman wrote:
> On Wed, Dec 05, 2018 at 02:20:11PM +0100, Michal Simek wrote:
>> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>
>> Initialise the device wakeup.
> 
> Why?  This says what happened, which you can see from the patch itself,
> but it does not say why this is needed at all.

We will fix this.

> 
> Also, you sent 4 patches, without any numbering, so I have no idea what
> order to apply them in.
>
> Please fix the changelog entries up and send this as a patch series so
> that I can correctly apply them.

They are all independent that's why I have sent them separately as
single patches.

Thanks,
Michal
