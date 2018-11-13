From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 06/10] dt-bindings: serial: Add bindings for
 nvidia,tegra194-tcu
Date: Tue, 13 Nov 2018 10:11:40 +0000
Message-ID: <a3256616-b300-6be9-1250-b481d686431d@nvidia.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-7-thierry.reding@gmail.com>
 <f7d19f6e-0dcd-753c-a407-fcec4fa1474b@nvidia.com>
 <20181113100355.GA15642@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181113100355.GA15642@ulmo>
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
To: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jassi Brar <jassisinghbrar@gmail.com>, Mika Liljeberg <mliljeberg@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Timo Alho <talho@nvidia.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-tegra@vger.kernel.org, Pekka Pessi <ppessi@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


On 13/11/2018 10:03, Thierry Reding wrote:
> On Tue, Nov 13, 2018 at 09:39:08AM +0000, Jon Hunter wrote:
>>
>> On 12/11/2018 15:18, Thierry Reding wrote:
>>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>>
>>> Add bindings for the Tegra Combined UART device used to talk to the
>>> UART console on Tegra194 systems.
>>>
>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>>  .../bindings/serial/nvidia,tegra194-tcu.txt   | 35 +++++++++++++++++++
>>>  1 file changed, 35 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
>>> new file mode 100644
>>> index 000000000000..085a8591accd
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
>>> @@ -0,0 +1,35 @@
>>> +NVIDIA Tegra Combined UART (TCU)
>>> +
>>> +The TCU is a system for sharing a hardware UART instance among multiple
>>> +systems within the Tegra SoC. It is implemented through a mailbox-
>>> +based protocol where each "virtual UART" has a pair of mailboxes, one
>>> +for transmitting and one for receiving, that is used to communicate
>>> +with the hardware implementing the TCU.
>>> +
>>> +Required properties:
>>> +- name : Should be tcu
>>> +- compatible
>>> +    Array of strings
>>> +    One of:
>>> +    - "nvidia,tegra194-tcu"
>>> +- mbox-names:
>>> +    "rx" - Mailbox for receiving data from hardware UART
>>> +    "tx" - Mailbox for transmitting data to hardware UART
>>> +- mboxes: Mailboxes corresponding to the mbox-names.
>>
>> Looks like there is some trailing white-space in the above line and git
>> warns after applying this patch.
> 
> I'm not seeing it. I remember seeing that trailing space in an earlier
> version of this patch and fixing it up. Did you perhaps end up applying
> the wrong version?

Yes you are right. This version does not have it. Seems that thunderbird
does not correctly overwrite the previous mbox but once I deleted and
saved again, I no longer see this.

Sorry for the noise. Jon

-- 
nvpublic
