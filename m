From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH v2] tty: ar933x_uart: add device tree support and binding
 documentation
Date: Fri, 30 Aug 2013 23:49:41 +0200
Message-ID: <52211375.8040609@openwrt.org>
References: <1377769695-27397-1-git-send-email-juhosg@openwrt.org> <20130830211327.GA30138@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:33340 "EHLO
	mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662Ab3H3VtN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 30 Aug 2013 17:49:13 -0400
In-Reply-To: <20130830211327.GA30138@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org

2013.08.30. 23:13 keltez=E9ssel, Greg Kroah-Hartman =EDrta:
> On Thu, Aug 29, 2013 at 11:48:15AM +0200, Gabor Juhos wrote:
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
>>   - move the doc from bindings/tty/serial to bindings/serial
>>
>> The patch is agains the 'tty-next' branch of the
>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tree
>=20
> No it isn't, it fails to apply here :(

Well, it was created on top of ...

  commit 9dfe59f15195b8c5bd4c2950266877c51fc329f0
  Author: Stephen Boyd <sboyd@codeaurora.org>
  Date:   Wed Aug 28 13:32:41 2013 -0700

      ARM: dts: msm: Update uartdm compatible strings

      Let's follow the ratified DT binding and use uartdm instead of
      hsuart. This does break backwards compatibility but this
      shouldn't be a problem because the uart driver isn't probing on
      these devices without adding clock support (which isn't merged so
      far).

      Cc: David Brown <davidb@codeaurora.org>
      Acked-by: Kumar Gala <galak@codeaurora.org>
      Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

=2E.. and i can still apply the patch on top of that commit.

However the current tty-next tree contains the previous version of the =
patch:

  commit dd910d98a2e240443db0090b0ae8a719a4a460f8
  Author: Gabor Juhos <juhosg@openwrt.org>
  Date:   Thu Aug 29 08:44:01 2013 +0200

      tty: ar933x_uart: add device tree support and binding documentati=
on

    Modify the probe routine to get the port line number
    from device tree if the 'of_node' is populated in the
    platform device. The driver can be built as module,
    thus add an OF specific module device table as well
    to support module auto loading.

    This makes it possible to use the driver for AR9330
    UART devices specified in device tree.

    Cc: devicetree@vger.kernel.org
    Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

And that is the reason why you can't apply v2. Probably you have missed=
 my
preceding [1] mail.

What should I do now? Should I send a follow-up patch which moves the
documentation from 'bindings/tty/serial' to bindings/serial?

Thanks,
Gabor

http://marc.info/?l=3Dlinux-serial&m=3D137776943126968&w=3D2

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
