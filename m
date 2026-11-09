Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794262011;
	b=hv0yJCH9bN/5V+qY994+6QvuFGs+DGY4WO2J7oyT9QQOQ6Z+ncKo8Z0eEIGrqeSbMIab
	 XpIo6sDVEVZbQpK6rNYWuzG4DtaevQ4OceOVAK/6YiawQjSj9M4X+6JUcd60f6ounn9Yt
	 CBlCrgoHN0bvMYuHmrgxLz97/N3+dJev3jy7feMujQ0HDwr+vLWkQ0t0RilItEGdqh1rl
	 95LC+8T3z6CbeQGDOk0t5nqtSNPEO2Q+ingSIgJhmwJ0J1QOQ6a+Jd6ruSWYrk+flvsSE
	 cm8PIBffyrJVg5WrEtqrTN2XKyqsP7AbhLfiKu2sFzPN7fwFaj8Wyy5VAiF/rr/xdzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262011;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=t2+WFOl4jOfThUR5eHCL+U8ZKopHXwLxKhpsdWMufzQ=;
	b=psNHQgdoL336W+6EEGL4iIe3xs4DQe6oDGHAz/Ai/r1RVPouWppcH97ppSVm9H4h073Q
	 7CmH2ugnuy4yQVAnRHO/ffPcLUzo7n3bIhxlYPXl9mkj8CjCN5bQhWq+CLCqIJ5C/wTm8
	 VntEf4GZUayy8WfX7QM1kZWdh2UU32CS54q1IvbdAs70dxIrAERRBCxhPD1wqTbl7RBZO
	 TrE9sZiPiAJnkbc5Tse4mb4en1G+EW/q/Xhs2J1sneUBdw4LSbXxGZS6dQIFyD0mW99pb
	 VyPhxJKuzbgjqExOcUUp8k6URmGD186QIpZuzgTcogrR6tQJw53j1q45DzijkMIbJZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKlDOfNK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22A4606A321;
	Mon,  9 Nov 2026 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKlDOfNK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794262010;
	b=HQev7O/f3HSX/sjFxYNyRQyCC5yYk6nvOb5HBT1Af5vCiX96z98K5XU9Ygy4mS68Z2Ja
	 8gT1NcrNqBdC0IoPpfEgcH1j0nLxN4drWkHWLrJTmhG4EprF5RTDFhgOXAMFXi4k7biF2
	 l9WSK02Kvv37+5yJoVKFgpZZ/GC3OdGGaRRjJEhVEpORxyUi+g4RTfSbGpngD3ryNa/UL
	 KGg57FZrq9eJhtLJ6AkBs92HyoS2cnQOokmjB5axEfXjXlkRMPKqqdxYvupLPcEDuTCqO
	 rz++0dARySFUQO9dphdb0LWQskXf53RWnq7K7EknpQG45M6iTUiBFF2D8bfTPf3M17Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794262010;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=t2+WFOl4jOfThUR5eHCL+U8ZKopHXwLxKhpsdWMufzQ=;
	b=e7ClXhLuRBTr3plbo1zJkmj+8OZagKmoxT8cCNxjx2J+7fZmy4yT1maOXi3lekhiL9qk
	 qE1ul3LkhycJAZXB2kBMCCuUoRze+WZfQlm/jG2K4VSJUwpfqep2CNTw8fYkeMe0VmSQO
	 A1089KNMCzbicUub/DwuGziCOrLKrNLOxJiJzN3YblRs5JMoNjxH5yq9WIgPzSEP/7Egv
	 T73rGS/QiKSLp1Q/wA2sJeqsnecoz5vQdDvH1RSb5mwAkGHb09mhhfb9bF43TJuhBb+4E
	 NJcjPM7COU1NawhzTPB5ccb9DpT90LlC3Io2V0YK5xGGjZI8WZS17vyMyp/iyvOcuNQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CB95F1F0089F;
	Mon,  9 Nov 2026 22:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262010;
	bh=t2+WFOl4jOfThUR5eHCL+U8ZKopHXwLxKhpsdWMufzQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=GKlDOfNKAe7LzmId1qzCymiVXGXl9D6OeZ0SVlixVRnG7ig8KM+IK+FFPjQ7asbL1
	 ugZkFivdXajSnmPbqv3ZusTquoBtTdnUJXDXMUg1Cq6egrT5ojlXLpjKOUiyGrXzU2
	 1QnzEGVL7TchUFGug2DqAbAp2SdSXqf9iaujnLNQINq4F7xdPWfbxEr2Ie26AAV6OC
	 5ixE6mr4CCus7IflL5rCc0b+kLy+pDeShSNfR5qocOcoJN7MdnbeZz81i+1KZ5dP6P
	 e6M1HSq4zSg35eZxKHyhoAjrJdWd/ztJk6DfFaL+iweo7az7+S5RIoQBLj4mMoCLKH
	 +vROZuzZCTTBg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5CE764869E;
	Mon,  9 Nov 2026 22:06:49 +0000 (UTC)
From: Kohei Otsuka via B4 Relay <devnull+kohei.spacemachines.com@kernel.org>
Subject: [PATCH v3 0/2] serial: 8250_of: RS-485 on Microchip Core16550
Date: Tue, 10 Nov 2026 09:06:47 +1100
Message-Id: <20261110-core16550-rs485-v3-0-4294334243fa@spacemachines.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ7CIBQE0Ks0rMXwQVpx5T2MC6C/FhNLA5Vom
 t5dqBsTdTnJzJuZRAwOIzlUMwmYXHR+yEFsKmJ7PVyQujZnwhmvAZig1geEWkpGQ9ztJZVM6o5
 1nUY0JK/GgJ17rOLp/M7xbq5op8KURu/i5MNzvUxQev/1BJTRugWJBgGlUcc4aos3bXs3YNxaf
 yPlJfFPR307PDsapBLCNkax5pezLMsL/9CM5xABAAA=
X-Change-ID: 20261103-core16550-rs485-505af0ffaeeb
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 conor.dooley@microchip.com, Kohei Otsuka <kohei@spacemachines.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794262008; l=3104;
 i=kohei@spacemachines.com; s=20261103; h=from:subject:message-id;
 bh=2t/y+JgPR+YcsPrIb1nJlI+zK2fJ6JA0sGv09e5rrOA=;
 b=hZzUdKg2K6uNjMYDff3C8oXouSGZf4MSIFlp63W0xXWUMs1PX4rxILMm+li+MtEhHAM9h7+Qj
 FMbE2lKaNOvAUv5GLdl8sZb5PUv4IXmEqjUGdbQqOn/fU7zDUkKPlwe
X-Developer-Key: i=kohei@spacemachines.com; a=ed25519;
 pk=1kit/vmX5JiLGH9NPcqlvT55ISWaLmNipdL5VrriRt0=
X-Endpoint-Received: by B4 Relay for kohei@spacemachines.com/20261103 with
 auth_id=1385
X-Original-From: Kohei Otsuka <kohei@spacemachines.com>
Reply-To: kohei@spacemachines.com

Core16550 is a 16550-compatible UART soft IP for Microchip FPGAs. We use
four of them in the fabric of a PolarFire SoC Icicle Kit as RS-485
ports, described as "ns16550a" with linux,rs485-enabled-at-boot-time.
With RS-485 enabled, RTS (the transceiver's driver enable) goes high at
the start of the first transmission and never drops, and the port stops
receiving. Core16550, like the original 16550A, raises no interrupt on
TEMT, so __stop_tx() waits for one forever unless the port has
UART_CAP_NOTEMT, which 8250_of never sets.

Testing, on a PolarFire SoC Icicle Kit with four Core16550 instances
on FIC3 (PCLK 50 MHz), linux-mchp 6.18.17 with this series applied
and the ports described as "microchip,core16550-rtl-v3",
115200 8N1, against USB-RS485 (2-wire, half duplex) and USB-RS422
(4-wire) converters:
- All four ports transmit and receive correctly with both converters.
- On RS-485, each port keeps receiving after transmitting, across
  repeated request/response exchanges in both directions.
- Without the series, RTS stays high after the first transmission and
  nothing more is received.

This series was prepared with the help of an AI coding assistant
(Claude, Anthropic): the analysis of __stop_tx(), both patches and
these messages. I reviewed and tested the result and take
responsibility for it.

Link: https://github.com/linux4microchip/meta-mchp/issues/5

Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>
---
Changes in v3:
- dt-bindings: drop the ns16550a fallback, as the generic driver leaves
  RTS asserted in RS-485 mode (Conor)
- 8250_of: match microchip,core16550-rtl-v3 directly, as a PORT_16550A,
  and retitle the patch to match
- Link to v2: https://patch.msgid.link/20261109-core16550-rs485-v2-0-a15933c7b907@spacemachines.com

Changes in v2:
- dt-bindings: rename the compatible to microchip,core16550-rtl-v3,
  following the -rtl-vN convention of Microchip's other fabric cores
  (Conor)
- dt-bindings: explain in the commit message why ns16550a remains a
  valid fallback (Conor)
- 8250_of: match microchip,core16550-rtl-v3
- Dropped Krzysztof's Acked-by on 1/2, as the compatible changed
- Link to v1: https://patch.msgid.link/20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Lubomir Rintel <lkundrak@v3.sk>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org

---
Kohei Otsuka (2):
      dt-bindings: serial: 8250: add Microchip Core16550
      serial: 8250_of: add Microchip Core16550

 Documentation/devicetree/bindings/serial/8250.yaml |  1 +
 drivers/tty/serial/8250/8250_of.c                  | 12 ++++++++++++
 2 files changed, 13 insertions(+)
---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261103-core16550-rs485-505af0ffaeeb

Best regards,
--  
Kohei Otsuka <kohei@spacemachines.com>


