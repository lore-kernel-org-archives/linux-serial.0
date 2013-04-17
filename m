From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 0/4] ARM: davinci: fix UART clock enabling
Date: Wed, 17 Apr 2013 15:45:12 +0530
Message-ID: <516E7630.7020906@ti.com>
References: <1365510481-32129-1-git-send-email-prakash.pm@ti.com>
 <A73F36158E33644199EB82C5EC81C7BC3EA4DCC9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <A73F36158E33644199EB82C5EC81C7BC3EA4DCC9@DBDE01.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "hs@denx.de" <hs@denx.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org



On 4/17/2013 12:02 PM, Manjunathappa, Prakash wrote:
> Hi Sekhar,
> 
> On Tue, Apr 09, 2013 at 17:57:57, Manjunathappa, Prakash wrote:
>> Patch series addresses below issues:
>> 1) Do clk_get on dev_id when there is single clock for a module
>> 2) Fix garbled UART log with DT kernel on da850-evm.
>>
> 
> Could you please accept this series if you do not have review comments?

I have not yet gotten to reviewing this. Its unlikely it will get
reviewed and accepted for v3.10 so this will have to wait for v3.11.

Thanks,
Sekhar
