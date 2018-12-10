From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: 8250: Add rate limit for
 serial port input overruns
Date: Mon, 10 Dec 2018 17:23:05 -0600
Message-ID: <20181210232305.GA11474@bogus>
References: <20181209222739.15866-1-darwin.dingel@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209222739.15866-1-darwin.dingel@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, chris.packham@alliedtelesis.co.nz, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
List-Id: linux-serial@vger.kernel.org

On Mon, 10 Dec 2018 11:27:39 +1300, Darwin Dingel wrote:
> When a serial port continuously experiences input overrun from
> (1) continuous receive characters from remote and or (2) hardware
> issues, its interrupt handler can preempt other tasks especially
> when the system is busy (ie. boot up period). This can cause other
> tasks to get starved of processing time from the CPU.
> 
> When this dts binding is enabled and input overrun on the serial port
> is detected, serial port receive will be throttled to give some breathing
> room for processing other tasks. Value provided will be in milliseconds.
> 
> &serial0{
> 	overrun-throttle-ms = <500>;
> };
> 
> Signed-off-by: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changelog
>     v1->v2:
>     - Separated dts binding to another patch
>     
>     v2->v3:
>     - Fixed commit message and reviewed-by fields
> 
>  Documentation/devicetree/bindings/serial/8250.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
