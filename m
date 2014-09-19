From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCHv2] serial: 8250: Add Quark X1000 to 8250 PCI driver
Date: Fri, 19 Sep 2014 12:35:03 +0100
Message-ID: <541C14E7.8020208@nexus-software.ie>
References: <1411112629-3238-1-git-send-email-pure.logic@nexus-software.ie> <20140919105833.GB31784@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140919105833.GB31784@xps8300>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, "Chew, Kean Ho" <kean.ho.chew@intel.com>
List-Id: linux-serial@vger.kernel.org

On 19/09/14 11:58, Heikki Krogerus wrote:
> On Fri, Sep 19, 2014 at 08:43:49AM +0100, Bryan O'Donoghue wrote:
>> Adds PCI identifier for the X1000
>> Adds clocking and register size and register shift
>>
>> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
>> ---
>>   drivers/tty/serial/8250/8250_pci.c | 33 +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>
> The UART on Quark SoC has an integrated DMA engine and Kean Ho (CC'd)
> is working with support for it. The plan is to add completely separate
> probe driver for the Quark UART. Dealing with the integrated DMA
> engine is too much for a quirk in 8250_pci.c.
>
> So we can take this now and when Kean Ho is ready he needs to
> basically revert it, or you could already introduce the new probe
> driver, 8250_quark.c, and Kean Ho can then add the DMA engine handling
> later to it.
>
> IMO we should add the 8250_quark.c already now.

Sounds great - is the 8250_quark.c code ready ?

If so then fantastic I agree with you.

If not then, lets do as you suggest Heikki and apply the simple patch 
above in the interim.


Best,
BOD
