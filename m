From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Fri, 7 Dec 2018 11:49:46 +0530
Message-ID: <4f7a4211-47ee-1114-0974-a3b402178106@kapsi.fi>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
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
To: Jassi Brar <jassisinghbrar@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, mliljeberg@nvidia.com, Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com, linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org, ppessi@nvidia.com, Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 07/12/2018 11.26, Jassi Brar wrote:
>> I thought that I could also mitigate 2) by busy looping in the TCU driver,
>> but it turns out that that doesn't work. The reason is that since we are
>> in atomic context with all interrupts disabled, the mailbox won't ever
>> consume any new characters, so the read pointer in the circular buffer
>> won't increment, leaving me with no condition upon which to loop that
>> would work.
>>
> So you want to be able to rely on an emulated console (running on a
> totally different subsystem) to dump development-phase early-boot
> logs? At the cost of legitimizing busy looping in atomic context - one
> random driver messing up the api for ever. Maybe you could have the
> ring buffer in some shmem and only pass the number of valid characters
> in it, to the remote?
> 

I would like to note that this is the one and only console interface 
that exists on these systems, for both development phase and production. 
Other UARTs are not externally accessible on the systems, or they are 
comparatively difficult to access as they aren't intended to be used as 
consoles in the system design. The combination of hardware and firmware 
implementing the console is black box from software's point of view 
(similarly to any other UART HW). The interface has also been fixed at 
an early system design phase, as there are many operating systems 
running on these boards, each with their own drivers.

Cheers,
Mikko
