From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [v3 3/3] serial: 8250_dw: Add UPF_SKIP_TEST to flags depend on
 device tree
Date: Thu, 13 Aug 2015 14:20:05 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665B2535@IN01WEMBXB.internal.synopsys.com>
References: <1437886478-29273-1-git-send-email-noamc@ezchip.com>
 <1439378312-6463-1-git-send-email-noamc@ezchip.com>
 <1439378312-6463-2-git-send-email-noamc@ezchip.com>
 <1439378312-6463-3-git-send-email-noamc@ezchip.com>
 <1439378312-6463-4-git-send-email-noamc@ezchip.com>
 <55CB4740.7070703@hurleysoftware.com>
 <DB4PR02MB2722D091C4A40FC95B48070D67E0@DB4PR02MB272.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "@codeaurora.orggalak@codeaurora.org" <IMCEAINVALID-+40codeaurora+2Eorggalak+40codeaurora+2Eorg@eurprd02.prod.outlook.com>, "fransklaver@gmail.com" <fransklaver@gmail.com>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "vgupta@synopsys.com" <Vineet.Gupta1@synopsys.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter, Greg

On Wednesday 12 August 2015 09:21 PM, Noam Camus wrote:
>> From: Peter Hurley [mailto:peter@hurleysoftware.com] 
>> Sent: Wednesday, August 12, 2015 4:17 PM
>> I think Greg's question about the simulator still applies: why upstream this?
>> The simulator is not even identified so how is someone supposed to know this workaround applies?
>> The fact there are no in-tree DT users of this workaround argues against its acceptance.
> I am using UART peripheral for Synopsys simulator same as one used by arch/arc/plat-sim

The osci virtual platform uses nSIM with SystemC based peripheral models. The
issue is in that model and not in nsim per-se.

> I know this platform do not use CONFIG_SERIAL_8250_DW due to some problem I suspect it is relate to the loop test.

Indeed. If you look at git log of osci platform, there was a commit which switched
DT from dw uart driver to stock 8250. Unfortunately the changelog doesn't describe
in detail what the root cause was.

2013-05-16 6eda477b3c54 ARC: [nsimosci] Change .dts to use generic 8250 UART 


> Maybe Vineet Gupta or Alexey Brodkin from Synopsys which are CC here can comment.
>
> So It just happen for me to be a pioneer with this.
>
> More than that "no-loopback-test" is an option already exist for core 8250, and since DW is only an extension for this driver it should also benefit from this option.

It seems Noam has made some changes to model today and we might need this patch
after all. Noam ?

> If all this is yet not enough, should I re-send this "patch set" again without this specific patch?
>
> Regards,
> Noam Camus
>
