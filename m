From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 2/2] Documentation: devicetree: Add bindings for Wi2Wi w2sg0004 gps
Date: Sun, 2 Nov 2014 11:15:05 +0100
Message-ID: <F5FA9432-99FD-47CE-97BD-9B615AF72361@goldelico.com>
References: <1413491183-15018-1-git-send-email-marek@goldelico.com> <1413491183-15018-2-git-send-email-marek@goldelico.com> <20141017093714.GB4202@leverpostej> <D65FF64A-856F-47EC-B3DE-7F2FCE505087@goldelico.com> <20141017110043.GA5335@leverpostej> <27AD2801-6410-44E3-9E0C-911D73E6A457@goldelico.com> <20141020093536.GA25360@leverpostej> <7A9F8C73-6CBD-435A-934C-14A80FFE452F@goldelico.com> <FDDD1C99-81F9-4933-815A-CC686A19115E@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <FDDD1C99-81F9-4933-815A-CC686A19115E@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marek Belisko <marek@goldelico.com>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.de>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

ping (questions for directions at the end of the mail).

Am 24.10.2014 um 11:32 schrieb Dr. H. Nikolaus Schaller <hns@goldelico.=
com>:

>=20
> Am 20.10.2014 um 19:26 schrieb Dr. H. Nikolaus Schaller <hns@goldelic=
o.com>:
>=20
>> Hi,
>>=20
>> Am 20.10.2014 um 11:35 schrieb Mark Rutland <mark.rutland@arm.com>:
>>=20
>>> Hi,
>>>=20
>>> On Fri, Oct 17, 2014 at 08:55:50PM +0100, Dr. H. Nikolaus Schaller =
wrote:
>>>>=20
>>>> Am 17.10.2014 um 13:00 schrieb Mark Rutland <mark.rutland@arm.com>=
:
>>>>=20
>>>>> On Fri, Oct 17, 2014 at 11:16:42AM +0100, Dr. H. Nikolaus Schalle=
r wrote:
>>>>>>=20
>>>>>> Am 17.10.2014 um 11:37 schrieb Mark Rutland <mark.rutland@arm.co=
m>:
>>>>>>=20
>>>>>>> On Thu, Oct 16, 2014 at 09:26:23PM +0100, Marek Belisko wrote:
>>>>>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>>>>>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>>>>>>>> ---
>>>>>>>> .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    | 44 ++++++=
++++++++++++++++
>>>>>>>> 1 file changed, 44 insertions(+)
>>>>>>>> create mode 100644 Documentation/devicetree/bindings/misc/wi2w=
i,w2sg0004.txt
>>>>>>>>=20
>>>>>>>> diff --git a/Documentation/devicetree/bindings/misc/wi2wi,w2sg=
0004.txt b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000..e144441
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.tx=
t
>>>>>>>> @@ -0,0 +1,44 @@
>>>>>>>> +Wi2Wi GPS module connected through UART
>>>>>>>> +
>>>>>>>> +Required properties:
>>>>>>>> +- compatible: wi2wi,w2sg0004 or wi2wi,w2sg0084
>>>>>>>> +- pinctrl: specify two states (default and monitor). One is t=
he default (UART) mode
>>>>>>>> +  and the other is for monitoring the RX line by an interrupt
>>>>>>>> +- on-off-gpio: the GPIO that controls the module's on-off tog=
gle input
>>>>>>>> +
>>>>>>>> +Optional properties:
>>>>>>>> +- lna-suppy: an (optional) LNA regulator that is enabled toge=
ther with the GPS receiver
>>>>>>>> +
>>>>>>>> +example:
>>>>>>>> +
>>>>>>>> +        gps_receiver: w2sg0004 {
>>>>>>>> +                compatible =3D "wi2wi,w2sg0004";
>>>>>>>=20
>>>>>>> I couldn't spot "wi2wi" in
>>>>>>> Documentation/devicetree/bindings/vendor-prefixes.txt (in mainl=
ine).
>>>>>>>=20
>>>>>>> Could you please add it?
>>>>>>>=20
>>>>>>>> +                gpio-controller;
>>>>>>>> +                #gpio-cells =3D <2>;
>>>>>>>=20
>>>>>>> As far as I can see, these properties aren't necessary. This on=
ly
>>>>>>> consumes a GPIO, it doesn't provide any.
>>>>>>=20
>>>>>> Well, it provides one GPIO. Sort of a "virtual=93 GPIO. It is ne=
eded so that=20
>>>>>> it can be wired up to the DTR gpio of the UART driver (unfortuna=
tely this
>>>>>> patch was reverted some months ago from mainline and we will rei=
ntroduce
>>>>>> it soon).
>>>>>=20
>>>>> If this GPIO doesn't really exist, then it's a Linux internal
>>>>> implementation detail rather than a description of the hardware, =
and
>>>>> doesn't really belong in the DT.
>>>>=20
>>>> Hm.=20
>>>>=20
>>>> Let=92s describe it differently.
>>>>=20
>>>> I can see the Linux driver module as a simple software simulation =
for a
>>>> piece of hardware that could have been connected between the UART
>>>> and the GPS chip.
>>>>=20
>>>> Basically it is a pulse-generator and a flip-flop to detect data f=
low on the RX
>>>> wire. This could be implemented by an external FPGA or uController=
=2E Or as
>>>> it is done on our board for saving hardware by a mix of the main C=
PU hardware
>>>> (Pinmux + GPIO + IRQ) and a kernel driver.
>>>>=20
>>>> The best of course would have been if the w2sg0004 would have a ph=
ysical
>>>> =84enable=93 GPIO (instead of that on-off control input).
>>>>=20
>>>> Then we would hook up that enable to some physical GPIO of the CPU
>>>> and simply refer to it as e.g. <&gpio4 12>. And would not even nee=
d a driver
>>>> for it (unless we want to make rfkill gps work).
>>>>=20
>>>> Therefore the driver we suggest provides an additional gpio contro=
ller with a
>>>> single GPIO so that we can write <&w2sg 0> to refer to this virtua=
l gpio.
>>>>=20
>>>> So in fact we try to wrap a non-optimal chip design by the driver =
and make it
>>>> appear as a standard GPIO interface to the DT and user space and w=
hoever
>>>> needs simply to enable/disable the GPS chip.
>>>=20
>>> The fact remains that this does not accurately represent the hardwa=
re,
>>> and is unnecessarily strongly tied to a particular UART design (whe=
re
>>> the DTR line is a separate UART).
>>=20
>> I don=92t get that it is tied to a particular UART design (except th=
at our DTR
>> patch affects to omap-serial only).
>>=20
>> Let=92s describe the facts:
>>=20
>> The chip has this interface:
>>=20
>> GPS-TX (output)
>> GPS-RX (input)
>> ON/OFF (input) - to toggle the power state of the chip
>>=20
>> They are connected to an OMAP3 UART2 as
>>=20
>> UART2-TX > GPS-RX
>> UART2-RX <- GPS-TX
>> GPIO145 -> ON/OFF
>>=20
>> That=92s it.
>>=20
>> If the chip (or any other serial GPS receiver like a Garmin) were co=
nnected
>> through real RS232 we would have
>>=20
>> UART2-TX -> level shifter -> cable -> level shifter -> GPS-RX
>> UART2-RX <- level shifter <- cable <- level shifter <- GPS-TX
>> DTR-GPIO -> level shifter (DTR line) -> cable -> level shifter -> po=
wer-management logic -> ON/OFF
>>=20
>> But because it is connected directly, we need to implement the power=
-management
>> logic between the DTR-GPIO and GPIO145:
>>=20
>> DTR-GPIO -> driver -> GPIO145 -> ON/OFF
>>=20
>> To correctly determine the state we need to tap the RX signal before
>> it enters the UART2-RX (it is pinmuxed with GPIO147):
>>=20
>> UART2-RX <=97=97+
>>                              OMAP3 pinmux <- OMAP3 pad <- GPS-TX
>>  GPIO147 <=97=97+
>>=20
>> So if we describe the driver as a box we have
>>=20
>> inputs from user space:
>> * rfkill for GPS
>> * a control that is activated by opening /dev/tty
>>=20
>> outputs to system:
>> * a control to switch the pinmux between RX and GPIO (interrupt)
>> * a control to external hardware
>>=20
>>>=20
>>>>> It sounds like what we actually need is the ability to describe d=
evices
>>>>> attached to UARTs.
>>>>=20
>>>> Hm. The purpose of the driver is power control of the chip. Not th=
e serial
>>>> interface.
>>>=20
>>> I'm not sure I follow your point. By describing the device as attac=
hed
>>> to the UART, the kernel can figure out that when said UART is acces=
sed
>>> the attached device needs to be on (and must be poked as necessary)=
=2E
>>=20
>> Why do we need to describe this? It is all about controlling the GPI=
O145,
>> GPIO147 and pinmux. But not RX or TX.
>>=20
>> So the driver does not need to know anything about UARTs (and if we
>> connect it to UART3 we only have to specify different GPIOs).
>>=20
>> Only our board specific dtb connects the UART to the =93virtual=94 G=
PIO
>> provided by the driver.
>>=20
>> This also brings up a minor problem: on OMAP3 some UART RX lines can
>> be pinmuxed with different GPIOs. So putting the driver under some U=
ART2
>> node doesn=92t uniquely define the GPIO number to monitor RX and mig=
ht
>> become a mess.
>>=20
>>>=20
>>> The power management logic for the device can stay in the device dr=
iver,
>>> and the power management logic for the UART can stay in the UART dr=
iver.
>>=20
>> Here I can=92t follow you. What power management does an UART driver=
 provide?
>>=20
>>> Neither would need to know about each other's internal details
>>> (e.g.GPIOs, for DTR or otherwise).
>>=20
>> Yes, that is our goal and in our solution they don=92t need to make =
assumptions
>> about each other. We just define in the DT: this GTA04 board has UAR=
T2-DTR
>> connected to the W2SG-GPIO# - instead of OMAP3-GPIO145.
>>=20
>> In our solution the UART driver knows that there could be a DTR GPIO=
 (similar to
>> a RTS GPIO which is already provided by the omap-serial RS484 bindin=
gs). Which
>> could be connected to some GPIO which drives the real DTR wire of a =
RS232 level
>> shifter.
>>=20
>>>=20
>>>>> Then you could have a mechanism whereby the UART
>>>>> driver can notify the other device driver regarding events (e.g. =
the
>>>>> UART being opened for access), or the other driver could claim ow=
nership
>>>>> of the UART and expose its own interface to userspace.
>>>>>=20
>>>>> That would be independent of the particular UART or other device,=
 and
>>>>> the only description necessary in the DT would be an accurate
>>>>> representation of the way the hardware is wired.
>>>>>=20
>>>>> There are a few ways that could be done, but I suspect the simple=
st is
>>>>> to just have the device as a sub-node of the UART, like we do for=
 SPI or
>>>>> I2C buses:
>>>>>=20
>>>>> 	serial@f00 {
>>>>> 		compatible =3D "vendor,uart";
>>>>> 		reg =3D <0xf00 0x100>;
>>>>> 		...
>>>>>=20
>>>>> 		gps {
>>>>> 			compatible =3D "wi2wi,w2sg0004";
>>>>> 			...
>>>>> 		};
>>>>> 	};
>>>>>=20
>>>>> That wouldn't work for devices with multiple UART connections. Do=
 those
>>>>> exist, and are they common in configurations where out-of-band
>>>>> management is necessary (e.g. regulators, clocks)?
>>>>=20
>>>> UARTs are usually point to point interfaces and not busses. So the=
re is
>>>> no need to describe the interface.
>>>=20
>>> I don't follow. You have a device which seems to require management
>>> kernel-side.
>>=20
>> Yes, power on/off.
>>=20
>>> Rather than describing the interface, you've described a
>>> fictitious relationship between the GPS device and the UART's DTR G=
PIO,
>>> and you=92ve described a fictitious GPIO to hand to the UART driver=
=2E
>>=20
>> Yes. Because the UART driver would generally expect a GPIO (if a GPI=
O driven
>> DTR hardware line is available on the connector).
>>=20
>>> This
>>> is how you have linked the two in order to get the behaviour you wa=
nt.
>>=20
>> Exactly.
>>=20
>>>=20
>>> So it _is_ necessary to describe the interface. Rather than describ=
ing
>>> that interface at a high level you've chosen to hack together a set=
 of
>>> fake relationships to work around the lack of ability to describe s=
aid
>>> interface.
>>=20
>> The power control interface is a single GPIO from UART to the driver=
=2E
>> The other end is an interface from the driver to the pinmux of the O=
MAP
>> and the chip. So it is a =93middleman=94. But I think this is alread=
y clear.
>>=20
>>>=20
>>>> And I would speculate that in most cases they simply go to some
>>>> connector and therefore no connected chip that needs to be describ=
ed
>>>> in the DT at all. Because it has a user-space driver (e.g. AT
>>>> commands) and no kernel driver.
>>>=20
>>> In the case where no driver is necessary I agree that no descriptio=
n is
>>> necessary, though the description could be exposed in a helpful way=
 to
>>> userspace to describe what=92s attached to which UARTs.
>>=20
>> That is usually done by configuring the gpsd process.
>>=20
>>>=20
>>> However, in this case you do have a kernel driver (even if basic), =
and
>>> it requires some knowledge of the relationship between the device a=
nd
>>> the UART in order to function.
>>=20
>> Yes. And that is what we want to provide by the dtb file. That one s=
hould describe
>> the relationship.
>>=20
>>>=20
>>>> But we have no idea how such a solution could be implemented or te=
sted.
>>>=20
>>> I would disagree on that point, given I provided a high level
>>> description of how this could be implemented.
>>=20
>> We do understand how you suggest the bindings should look like, but =
we have
>> no idea how that translates into code.
>>=20
>> And we do not want to touch the general serial drivers, just the oma=
p-serial
>> (because the solutions does not work without an UART behind a pinmux=
 with a
>> GPIO with interrupt capabilities).
>>=20
>> We simply have no experience modifying serial drivers (Linux is too =
big that anyone
>> can know all areas).
>>=20
>> Our experience is limited to re-submitting the DTR-GPIO-control patc=
h by Neil Brown
>> and making it read DT properties instead of board file.
>>=20
>> So your approach needs a lot of help to really implement it. The que=
stion is who
>> will be doing it.
>>=20
>>>=20
>>>> If someone adds that to the serial drivers, we would be happy to u=
se it,
>>>> but unless such a thing exists, I think our solution is quite simp=
le and isolated
>>>> into this single driver and also uses existing standard interfaces=
 (gpios, pinmux).
>>>=20
>>> I would argue that this _abuses_ standard interfaces, as you have o=
ne
>>> device driver fiddling with resources logically owned by another.
>>>=20
>>>>>> The reason to solve it that way is that we did not want to have =
a direct link
>>>>>> between this driver and any serial drivers or other mechanisms h=
ow drivers
>>>>>> can detect that their serial port (/dev/tty*) is opened.
>>>>>>=20
>>>>>> It is used to power down the w2sg GPS chip if no user space proc=
ess is
>>>>>> accessing its serial port (or de-asserts DTR through tcsetattr/i=
octl).
>>>>>>=20
>>>>>>>=20
>>>>>>>> +
>>>>>>>> +                pinctrl-names =3D "default", "monitor";
>>>>>>>> +                pinctrl-0 =3D <&uart2_pins>;
>>>>>>>> +                pinctrl-1 =3D <&uart2_rx_irq_pins>;
>>>>>>>> +
>>>>>>>> +                interrupt-parent =3D <&gpio5>;
>>>>>>>> +                interrupts =3D <19 IRQ_TYPE_EDGE_FALLING>;  /=
* GPIO_147: RX - trigger on arrival of start bit */
>>>>>>>=20
>>>>>>> While interrupts is a standard property, please describe above =
how many
>>>>>>> you expect and what their logical function is.
>>>>>>>=20
>>>>>>> The only part I'm confused about is how the link to the UART is
>>>>>>> described. I assume I'm just ignorant of some existing pattern.
>>>>>>=20
>>>>>> The serial link itself is not described at all because it is ass=
umed to be a =84must have=93.
>>>>>=20
>>>>> Huh? So it's a "must have" that you "don't have" in the DT?
>>>>=20
>>>> Yes. The DT does not describe everything. Only those things that n=
eed
>>>> a kernel driver. And UARTs usually have user-space drivers (e.g. g=
psd,
>>>> gsmd, pppd) and ioctl/tcsetattr.
>>>=20
>>> The DT should describe the static portions of the hardware. Typical=
ly we
>>> only have devices with kernelspace drivers described simply because
>>> that's the way people have built DTs. Whether or not you have a
>>> kernelspace driver can change over time, the organisation of the
>>> hardware cannot.
>>=20
>> So far none of the DT I have seen describe what is connected to the =
UART.
>> Even for boards which use HCI to communicate with a Bluetooth module=
=2E
>>=20
>>>=20
>>>>> I think that the relationship is being described incorrectly in t=
he DT,
>>>>> and I think that there is a more general problem that needs to be
>>>>> addressed in order to make this case work.
>>>>>=20
>>>>>> The driver only needs to monitor the RX line and needs to switch=
 it between UART and
>>>>>> GPIO/IRQ mode. So this monitoring switch is described (with two =
different pinctrl states).
>>>>>=20
>>>>> While this particular driver only needs that at this point in tim=
e,
>>>>> that's not necessarily true of drivers for similar devices, nor i=
s it
>>>>> necessarily true if we need to add additional features to this dr=
iver.
>>>>=20
>>>> Which features are you thinking of to add to this driver? And do
>>>> similar devices exist at all? Since we have not found any, we have
>>>> declared it as a "misc=93 driver.
>>>=20
>>> I don't have any particular feature in mind.
>>>=20
>>> I am not immediately aware of other serial devices which require
>>> out-of-band management in the same way, though we have a vaguely si=
milar
>>> case with SDIO devices which must be powered up before they appear =
on
>>> the bus.
>>=20
>> AFAIK, they are usually descibed by a regulator that is enabled/disa=
bled by
>> the SDIO driver. And the regulator is usually defined as a gpio-regu=
lator to
>> drive an GPIO.
>>=20
>> And I think the SDIO driver has a reset-gpio (which can also be inte=
rpreted
>> as a disable/power-down).
>>=20
>> So such interface drivers simply expect that they can power-control =
dependent
>> devices through a regulator or a simple gpio.
>>=20
>>> In that case I believe the intent is to describe them in the DT
>>> under the bus.
>>=20
>> Or would it be ok to allow a regulator property for the serial inter=
face? Then
>> our driver would become a w2sg0004-regulator driver similar to a gpi=
o-regulator
>> but with a state machine that knows how to pulse the gpio until powe=
r is applied
>> to the GPS receiver internals.
>>=20
>>>=20
>>>>> Describing the relationship leaves a lot more freedom to improve =
things
>>>>> without having to update every DTB.
>>>>>=20
>>>>>> We know that it is a little tricky to control this chip correctl=
y - and we think this solution
>>>>>> is the most general (no direct dependency on the serial line, an=
d just to pinmux states
>>>>>> and an interrupt).
>>>>>=20
>>>>> I think that the rough approach I sketched out above is more gene=
ral,
>>>>> and I think that you must describe the relationship with the seri=
al
>>>>> line.
>>>>>=20
>>>>> It's not clear to me whether the interrupt you describe is attach=
ed to
>>>>> the GPS, or if this is logically part of the UART.
>>>>=20
>>>> The interrupt is needed to simulate the glue logic connected betwe=
en
>>>> UART and GPS.
>>>>=20
>>>> The output signal comes from the GPS module and goes to some pad
>>>> of the OMAP3 SoC. This pad can be either multiplexed into the UART=
 RX
>>>> input or into a GPIO bank of the OMAP. That GPIO controller can ge=
nerate
>>>> the interrupt on incoming data (when none is expected).
>>>>=20
>>>> Therefore it is a GPS-generated interrupt and has nothing to do wi=
th
>>>> the UART.
>>>=20
>>> Ok. When does the GPS device raise this interrupt?
>>=20
>> If the driver assumes the GPS receiver is turned off, it disconnedts=
 the RX
>> wire from the UART to a GPIO by using two different pinmux states.
>>=20
>> If the GPIO raises an interrupt, the driver knows that the GPS modul=
e is not
>> turned off, because the driver has lost knowledge about its state. T=
his is not
>> an UART related function but OMAP pinmux and GPIO.
>>=20
>> I am not sure if that could even be implemented at all by a UART dep=
endent
>> driver (since the UART is shut down and does not interrupt).
>>=20
>>>=20
>>> Thanks,
>>> Mark.
>>=20
>> Thanks as well - it is a fruitful discussion (even if it becomes len=
gthy because
>> I might have repeated a lot of things that are already clear. Please=
 accept an apology).
>>=20
>> I think we just disagree about implementing a version that =93works=94=
 in a quite specific
>> setup (there are necessary assumptions about OMAP pinmux and omap-se=
rial) with
>> existing APIs versus a general one that might need a lot of changes =
outside the driver
>> and introduce new APIs.
>>=20
>> BR,
>> Nikolaus
>>=20
>=20
> After re-thinking what we have discussed so far (and considering othe=
r recommendations
> I have received off-list) I currently see these options/questions:
>=20
> * who could modify the serial drivers and APIs so that this driver ca=
n become
>  a subnode (=93bus client=94) of an UART? How long does it take to be=
come available?
>=20
> * would it be an option to rename it to =93gpio-w2sg0004=94 to better=
 describe that it
>  provides a (virtual) gpio?
>=20
> * would it be an option to simply rename the driver to =93w2sg0004-po=
wer=94
>  to make clear that it is not at all related to the UART data communi=
cation
>  channel but only controlling the power of the w2sg0004 chip?
>=20
> * both?
>=20
> * or would it be acceptable if this is a regulator driver that contro=
ls the LDO
>  inside this chip? I.e. describe it as a =93w2sg0004-regulator=94?
>=20
> This would be very similar to the function of a =93gpio-regulator=94:=
 convert
> =93regulator state=94 into a gpio state. But here convert =93on/off=94=
 into some impulses.
>=20
> And to resolve uncertainty about the real LDO state it would be able =
to monitor
> some feedback interrupt and handle an (optional) pinmux toggle.
>=20
> This would mean that we do not even need to mention anything about UA=
RTs
> in the driver bindings.
>=20
> Rather it would just say: the driver can monitor a (gpio) interrupt l=
ine to
> know if the attached device is active (when it is not expected, e.g. =
after boot).
>=20
> Since this monitor gpio is sometimes multiplexed with other features =
of the SoC,
> the driver can also switch between two pinctrl states (default and mo=
nitor).
>=20
> BR,
> Nikolaus
>=20
