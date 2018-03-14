From: Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [PATCH v4 3/3] ARM: dts: STi: Remove "console=ttyASN" from
 bootargs for STi boards
Date: Wed, 14 Mar 2018 14:53:17 +0000
Message-ID: <55befee5-dd68-c175-6d20-29ccda6f323f@st.com>
References: <1520444134-30144-1-git-send-email-patrice.chotard@st.com>
 <1520444134-30144-4-git-send-email-patrice.chotard@st.com>
 <20180314135701.GA20286@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180314135701.GA20286@kroah.com>
Content-Language: en-US
Content-ID: <59513823E431AF4CA47FCC14B24FF83F@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Greg

On 03/14/2018 02:57 PM, Greg KH wrote:
> On Wed, Mar 07, 2018 at 06:35:34PM +0100, patrice.chotard@st.com wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> As serial interface is already specified into stdout-path property,
>> "console=ttyASN,115200" from bootargs can be removed.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> ---
>> v4: _ none
>> v3: _ remove "console=serialN,115200" from bootargs and use prefered
>>        stdout-path property
>> v2: _ none
>>
> 
> This patch does not apply at all, are you sure you made it correctly?
> 
> Can you please fix it up and resend?

No problem, the patch has just been sent.

Thanks

Patrice

> 
> thanks,
> 
> greg k-h
> 
