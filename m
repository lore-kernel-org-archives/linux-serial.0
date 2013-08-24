From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH v2] tty: ar933x_uart: add device tree support and binding
 documentation
Date: Sat, 24 Aug 2013 13:53:45 +0200
Message-ID: <52189EC9.5040906@openwrt.org>
References: <1377769695-27397-1-git-send-email-juhosg@openwrt.org> <80D7C583-FF16-4789-B8D1-2D0881DAD8F0@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:60580 "EHLO
	mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186Ab3IEHxf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Sep 2013 03:53:35 -0400
In-Reply-To: <80D7C583-FF16-4789-B8D1-2D0881DAD8F0@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

2013.09.04. 0:16 keltez=E9ssel, Kumar Gala =EDrta:
>=20
> On Aug 29, 2013, at 4:48 AM, Gabor Juhos wrote:
>=20
>> Modify the probe routine to get the port line number
>> from device tree if the 'of_node' is populated in the
>> platform device. The driver can be built as module,
>> thus add an OF specific module device table as well
>> to support module auto loading.
>>
>> This makes it possible to use the driver for AR9330
>> UART devices specified in device tree.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
>> ---
>> Changes since v1:
>>  - move the doc from bindings/tty/serial to bindings/serial
>>
>> The patch is agains the 'tty-next' branch of the
>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tree
>> ---
>> .../devicetree/bindings/serial/qca,ar9330-uart.txt |   34 ++++++++++=
++++++++++
>> drivers/tty/serial/ar933x_uart.c                   |   28 ++++++++++=
++++--
>> 2 files changed, 59 insertions(+), 3 deletions(-)
>> create mode 100644 Documentation/devicetree/bindings/serial/qca,ar93=
30-uart.txt
>>
>> diff --git a/Documentation/devicetree/bindings/serial/qca,ar9330-uar=
t.txt b/Documentation/devicetree/bindings/serial/qca,ar9330-uart.txt
>> new file mode 100644
>> index 0000000..c5e032c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/qca,ar9330-uart.txt
>> @@ -0,0 +1,34 @@
>> +* Qualcomm Atheros AR9330 High-Speed UART
>> +
>> +Required properties:
>> +
>> +- compatible: Must be "qca,ar9330-uart"
>=20
> If the driver is called ar933x, is there a reason not to do so with t=
he compatible and binding spec?

Yes, there is a reason, the compatible string should not contain wildca=
rds. At
least the devicetree.org wiki [1] says the following:

  Warning: Don't use wildcard compatible values, like "fsl,mpc83xx-uart=
" or
  similar. Silicon vendors will invariably make a change that breaks yo=
ur wildcard
  assumptions the moment it is too late to change it. Instead, choose a=
 specific
  silicon implementations and make all subsequent silicon compatible wi=
th it.

Additionally, Grant Likely wrote the same thing here basically:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/0822=
65.html

-Gabor

1. http://devicetree.org/Device_Tree_Usage#Understanding_the_compatible=
_Property

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
